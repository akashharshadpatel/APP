import Foundation

struct CartItem: Codable, Hashable, Identifiable {
    var product: Product
    var variant: ProductVariant
    var quantity: Int

    var id: String { variant.id }
    var lineTotal: Decimal { variant.effectivePrice * Decimal(quantity) }
    var lineSavings: Decimal { (variant.price - variant.effectivePrice) * Decimal(quantity) }
}

/// Price breakdown for the bag, as returned by `CartService`.
struct CartQuote: Hashable {
    var subtotal: Decimal
    var savings: Decimal
    var estimatedTax: Decimal
    var total: Decimal
    /// Problems that block checkout (e.g. over the NJ purchase limit, out of stock).
    var issues: [String]

    static let empty = CartQuote(subtotal: 0, savings: 0, estimatedTax: 0, total: 0, issues: [])

    var canCheckout: Bool { issues.isEmpty && subtotal > 0 }
}
