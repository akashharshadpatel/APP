import Foundation

// These protocols are the only way the app talks to a backend.
// `MockDutchieService` implements them today; a real `DutchieService` will implement
// the same protocols later, and no screen or view model needs to change.

protocol ProductService {
    func fetchProducts(matching query: ProductQuery) async throws -> [Product]
    func fetchProduct(id: String) async throws -> Product
    func fetchProducts(ids: [String]) async throws -> [Product]
}

protocol CartService {
    /// Restores the bag saved on this device.
    func loadCart() async -> [CartItem]
    func saveCart(_ items: [CartItem]) async
    /// Prices the bag and checks it against stock and NJ purchase limits.
    func quote(for items: [CartItem]) async throws -> CartQuote
}

protocol OrderService {
    func fetchPickupSlots(on day: Date) async throws -> [PickupSlot]
    func placeOrder(_ request: OrderRequest) async throws -> Order
    func fetchOrders() async throws -> [Order]
    func fetchOrder(id: String) async throws -> Order
    func cancelOrder(id: String) async throws -> Order
}

protocol DealService {
    func fetchDeals() async throws -> [Deal]
}

protocol LoyaltyService {
    func fetchAccount() async throws -> LoyaltyAccount
    func redeem(rewardID: String) async throws -> LoyaltyAccount
}

protocol StoreService {
    func fetchStoreInfo() async throws -> StoreInfo
}

protocol AuthService {
    func currentUser() async -> UserProfile?
    func signIn(with credential: AppleSignInCredential) async throws -> UserProfile
    func signOut() async
}

enum ServiceError: LocalizedError, Equatable {
    case notFound
    case outOfStock(productName: String)
    case slotUnavailable
    case insufficientPoints
    case notSignedIn
    case network

    var errorDescription: String? {
        switch self {
        case .notFound: "We couldn't find that item."
        case .outOfStock(let name): "\(name) just sold out. Please remove it from your bag."
        case .slotUnavailable: "That pickup time just filled up. Please choose another."
        case .insufficientPoints: "You don't have enough points for that reward yet."
        case .notSignedIn: "Please sign in to continue."
        case .network: "We're having trouble connecting. Please try again."
        }
    }
}
