import Foundation

/// New Jersey adult-use per-transaction purchase limits.
/// Source: NJ Cannabis Regulatory Commission. Have your compliance lead confirm these values,
/// since the CRC can change them.
enum PurchaseLimits {
    /// 1 ounce of usable cannabis (flower and pre-rolls).
    static let flowerGrams: Double = 28.35
    /// Equivalent limit for concentrates, resins, oils and vape cartridges.
    static let concentrateGrams: Double = 5
    /// Equivalent limit for edibles and other ingestibles, in mg THC.
    static let ingestibleTHCMilligrams: Double = 1000

    /// Returns human-readable problems if the bag exceeds any limit.
    static func violations(for items: [CartItem]) -> [String] {
        var flower = 0.0
        var concentrate = 0.0
        var ingestibleMG = 0.0

        for item in items {
            let qty = Double(item.quantity)
            switch item.product.category {
            case .flower, .prerolls:
                flower += (item.variant.weightGrams ?? 0) * qty
            case .vapes, .concentrates:
                concentrate += (item.variant.weightGrams ?? 0) * qty
            case .edibles, .tinctures:
                ingestibleMG += (item.product.potency?.thc ?? 0) * qty
            case .topicals, .accessories:
                break
            }
        }

        // Each category counts as a share of the total allowance, so mixed bags are limited too.
        let share = flower / flowerGrams + concentrate / concentrateGrams + ingestibleMG / ingestibleTHCMilligrams
        if share > 1.0001 {
            return ["New Jersey limits each purchase to 1 oz of flower, or 5 g of concentrate, or 1,000 mg THC of edibles (or a combination). Please reduce the items in your bag."]
        }
        return []
    }
}
