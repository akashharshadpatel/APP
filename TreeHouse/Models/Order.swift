import Foundation

enum OrderStatus: String, Codable, CaseIterable, Hashable {
    case placed, preparing, ready, completed, cancelled

    var title: String {
        switch self {
        case .placed: "Order Placed"
        case .preparing: "Preparing"
        case .ready: "Ready for Pickup"
        case .completed: "Picked Up"
        case .cancelled: "Cancelled"
        }
    }

    var symbolName: String {
        switch self {
        case .placed: "checkmark.circle.fill"
        case .preparing: "shippingbox.fill"
        case .ready: "bag.fill"
        case .completed: "checkmark.seal.fill"
        case .cancelled: "xmark.circle.fill"
        }
    }

    /// Order still needs the customer's attention.
    var isActive: Bool {
        switch self {
        case .placed, .preparing, .ready: true
        case .completed, .cancelled: false
        }
    }

    /// The steps shown in the order tracker.
    static let trackerSteps: [OrderStatus] = [.placed, .preparing, .ready]
}

struct PickupSlot: Codable, Hashable, Identifiable {
    var id: String
    var start: Date
    var end: Date
    var isAvailable: Bool

    var timeRangeLabel: String {
        "\(start.formatted(date: .omitted, time: .shortened)) – \(end.formatted(date: .omitted, time: .shortened))"
    }
}

/// A snapshot of a product at the time it was ordered.
struct OrderLine: Codable, Hashable, Identifiable {
    var productID: String
    var variantID: String
    var productName: String
    var brand: String
    var variantLabel: String
    var category: ProductCategory
    var strainType: StrainType?
    var unitPrice: Decimal
    var quantity: Int

    var id: String { variantID }
    var lineTotal: Decimal { unitPrice * Decimal(quantity) }
}

struct Order: Codable, Hashable, Identifiable {
    var id: String
    /// Short code the customer shows at the counter, e.g. "TH-4821".
    var number: String
    var createdAt: Date
    var pickupSlot: PickupSlot
    var lines: [OrderLine]
    var subtotal: Decimal
    var savings: Decimal
    var estimatedTax: Decimal
    var total: Decimal
    var status: OrderStatus
    var customerName: String

    var itemCount: Int { lines.reduce(0) { $0 + $1.quantity } }
}

/// What the app sends to `OrderService.placeOrder`.
struct OrderRequest: Hashable {
    var items: [CartItem]
    var pickupSlot: PickupSlot
    var customerName: String
    var phoneNumber: String
    var notes: String
}
