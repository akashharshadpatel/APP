import Foundation

/// A stand-in for the Dutchie API. Implements every service protocol with realistic sample data,
/// a short artificial network delay, and on-device persistence for the bag, orders and sign-in.
actor MockDutchieService {
    /// NJ sales tax (6.625%). Local cannabis transfer taxes are typically included by the store;
    /// the real Dutchie quote will replace this estimate.
    static let salesTaxRate = Decimal(string: "0.06625")!

    private var products: [Product]
    private var orders: [Order]
    private var loyalty: LoyaltyAccount
    private var user: UserProfile?
    private let latency: Duration
    private let defaults: UserDefaults

    private enum Keys {
        static let cart = "mock.cart"
        static let orders = "mock.orders"
        static let user = "mock.user"
    }

    init(latency: Duration = .milliseconds(400), defaults: UserDefaults = .standard) {
        self.latency = latency
        self.defaults = defaults
        self.products = MockData.products
        self.loyalty = MockData.loyaltyAccount
        self.orders = Self.decode([Order].self, from: defaults.data(forKey: Keys.orders)) ?? MockData.pastOrders
        self.user = Self.decode(UserProfile.self, from: defaults.data(forKey: Keys.user))
    }

    static func estimatedTax(on subtotal: Decimal) -> Decimal {
        var raw = subtotal * salesTaxRate
        var rounded = Decimal()
        NSDecimalRound(&rounded, &raw, 2, .plain)
        return rounded
    }

    // MARK: - Helpers

    private func simulateLatency(_ multiplier: Double = 1) async {
        try? await Task.sleep(for: latency * multiplier)
    }

    private static func decode<T: Decodable>(_ type: T.Type, from data: Data?) -> T? {
        guard let data else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }

    private func persist<T: Encodable>(_ value: T?, key: String) {
        if let value, let data = try? JSONEncoder().encode(value) {
            defaults.set(data, forKey: key)
        } else {
            defaults.removeObject(forKey: key)
        }
    }

    private func currentVariant(for item: CartItem) -> (Product, ProductVariant)? {
        guard let product = products.first(where: { $0.id == item.product.id }),
              let variant = product.variant(id: item.variant.id) else { return nil }
        return (product, variant)
    }

    /// Simulates the store working on an order: Placed → Preparing (after 20s) → Ready (after 60s).
    private func progressed(_ order: Order) -> Order {
        guard order.status == .placed || order.status == .preparing else { return order }
        let elapsed = Date.now.timeIntervalSince(order.createdAt)
        var updated = order
        updated.status = elapsed < 20 ? .placed : (elapsed < 60 ? .preparing : .ready)
        return updated
    }
}

// MARK: - ProductService

extension MockDutchieService: ProductService {
    func fetchProducts(matching query: ProductQuery) async throws -> [Product] {
        await simulateLatency()
        return query.apply(to: products)
    }

    func fetchProduct(id: String) async throws -> Product {
        await simulateLatency(0.5)
        guard let product = products.first(where: { $0.id == id }) else { throw ServiceError.notFound }
        return product
    }

    func fetchProducts(ids: [String]) async throws -> [Product] {
        await simulateLatency(0.5)
        return ids.compactMap { id in products.first { $0.id == id } }
    }
}

// MARK: - CartService

extension MockDutchieService: CartService {
    func loadCart() async -> [CartItem] {
        Self.decode([CartItem].self, from: defaults.data(forKey: Keys.cart)) ?? []
    }

    func saveCart(_ items: [CartItem]) async {
        persist(items.isEmpty ? nil : items, key: Keys.cart)
    }

    func quote(for items: [CartItem]) async throws -> CartQuote {
        await simulateLatency(0.5)
        var issues = PurchaseLimits.violations(for: items)

        for item in items {
            guard let (product, variant) = currentVariant(for: item) else {
                issues.append("\(item.product.name) is no longer on the menu.")
                continue
            }
            if variant.quantityAvailable == 0 {
                issues.append("\(product.name) (\(variant.label)) is sold out.")
            } else if variant.quantityAvailable < item.quantity {
                issues.append("Only \(variant.quantityAvailable) left of \(product.name) (\(variant.label)).")
            }
        }

        let subtotal = items.reduce(Decimal(0)) { $0 + $1.lineTotal }
        let savings = items.reduce(Decimal(0)) { $0 + $1.lineSavings }
        let tax = Self.estimatedTax(on: subtotal)
        return CartQuote(subtotal: subtotal, savings: savings, estimatedTax: tax, total: subtotal + tax, issues: issues)
    }
}

// MARK: - OrderService

extension MockDutchieService: OrderService {
    func fetchPickupSlots(on day: Date) async throws -> [PickupSlot] {
        await simulateLatency(0.5)
        let calendar = Calendar.current
        guard let hours = MockData.store.hours(on: day, calendar: calendar) else { return [] }

        let startOfDay = calendar.startOfDay(for: day)
        // Orders need at least 30 minutes to prepare.
        let earliest = Date.now.addingTimeInterval(30 * 60)
        var slots: [PickupSlot] = []
        var minute = hours.opensAt

        while minute + 30 <= hours.closesAt {
            if let start = calendar.date(byAdding: .minute, value: minute, to: startOfDay),
               let end = calendar.date(byAdding: .minute, value: 30, to: start),
               start >= earliest {
                // Mark roughly one in seven slots as full so the UI shows unavailable times.
                let isFull = (minute / 30) % 7 == 3
                slots.append(PickupSlot(id: "slot-\(Int(start.timeIntervalSince1970))", start: start, end: end,
                                        isAvailable: !isFull))
            }
            minute += 30
        }
        return slots
    }

    func placeOrder(_ request: OrderRequest) async throws -> Order {
        await simulateLatency(2)
        guard request.pickupSlot.isAvailable else { throw ServiceError.slotUnavailable }

        var lines: [OrderLine] = []
        for item in request.items {
            guard let (product, variant) = currentVariant(for: item) else { throw ServiceError.notFound }
            guard variant.quantityAvailable >= item.quantity else {
                throw ServiceError.outOfStock(productName: product.name)
            }
            lines.append(OrderLine(productID: product.id, variantID: variant.id, productName: product.name,
                                   brand: product.brand, variantLabel: variant.label, category: product.category,
                                   strainType: product.strainType, unitPrice: variant.effectivePrice,
                                   quantity: item.quantity))
        }

        // Reserve inventory.
        for item in request.items {
            guard let productIndex = products.firstIndex(where: { $0.id == item.product.id }),
                  let variantIndex = products[productIndex].variants.firstIndex(where: { $0.id == item.variant.id })
            else { continue }
            products[productIndex].variants[variantIndex].quantityAvailable -= item.quantity
        }

        let pricing = try await quote(for: request.items)
        let number = "TH-\(Int.random(in: 4800...9999))"
        let order = Order(id: UUID().uuidString, number: number, createdAt: .now, pickupSlot: request.pickupSlot,
                          lines: lines, subtotal: pricing.subtotal, savings: pricing.savings,
                          estimatedTax: pricing.estimatedTax, total: pricing.total, status: .placed,
                          customerName: request.customerName)
        orders.insert(order, at: 0)
        persist(orders, key: Keys.orders)

        let earned = Int(pricing.subtotal.doubleValue.rounded(.down))
        loyalty.points += earned
        loyalty.lifetimePoints += earned
        loyalty.activity.insert(PointsActivity(id: UUID().uuidString, date: .now, title: "Order \(number)",
                                               points: earned), at: 0)
        return order
    }

    func fetchOrders() async throws -> [Order] {
        await simulateLatency()
        return orders.map(progressed)
    }

    func fetchOrder(id: String) async throws -> Order {
        await simulateLatency(0.3)
        guard let order = orders.first(where: { $0.id == id }) else { throw ServiceError.notFound }
        return progressed(order)
    }

    func cancelOrder(id: String) async throws -> Order {
        await simulateLatency()
        guard let index = orders.firstIndex(where: { $0.id == id }) else { throw ServiceError.notFound }
        orders[index].status = .cancelled
        persist(orders, key: Keys.orders)
        return orders[index]
    }
}

// MARK: - DealService

extension MockDutchieService: DealService {
    func fetchDeals() async throws -> [Deal] {
        await simulateLatency()
        return MockData.deals
    }
}

// MARK: - LoyaltyService

extension MockDutchieService: LoyaltyService {
    func fetchAccount() async throws -> LoyaltyAccount {
        await simulateLatency()
        return loyalty
    }

    func redeem(rewardID: String) async throws -> LoyaltyAccount {
        await simulateLatency()
        guard let reward = loyalty.rewards.first(where: { $0.id == rewardID }) else { throw ServiceError.notFound }
        guard loyalty.points >= reward.pointsCost else { throw ServiceError.insufficientPoints }
        loyalty.points -= reward.pointsCost
        loyalty.activity.insert(PointsActivity(id: UUID().uuidString, date: .now, title: "Redeemed \(reward.title)",
                                               points: -reward.pointsCost), at: 0)
        return loyalty
    }
}

// MARK: - StoreService

extension MockDutchieService: StoreService {
    func fetchStoreInfo() async throws -> StoreInfo {
        await simulateLatency(0.5)
        return MockData.store
    }
}

// MARK: - AuthService

extension MockDutchieService: AuthService {
    func currentUser() async -> UserProfile? {
        user
    }

    func signIn(with credential: AppleSignInCredential) async throws -> UserProfile {
        await simulateLatency()
        // Apple only shares the name and email the first time; keep what we already know after that.
        let profile = UserProfile(
            id: credential.userID,
            firstName: credential.givenName ?? user?.firstName ?? "",
            lastName: credential.familyName ?? user?.lastName ?? "",
            email: credential.email ?? user?.email,
            phoneNumber: user?.phoneNumber
        )
        user = profile
        persist(profile, key: Keys.user)
        return profile
    }

    func signOut() async {
        user = nil
        persist(Optional<UserProfile>.none, key: Keys.user)
    }
}
