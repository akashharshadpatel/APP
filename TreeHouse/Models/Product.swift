import Foundation

enum ProductCategory: String, Codable, CaseIterable, Identifiable, Hashable {
    case flower, prerolls, vapes, edibles, concentrates, tinctures, topicals, accessories

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .flower: "Flower"
        case .prerolls: "Pre-Rolls"
        case .vapes: "Vapes"
        case .edibles: "Edibles"
        case .concentrates: "Concentrates"
        case .tinctures: "Tinctures"
        case .topicals: "Topicals"
        case .accessories: "Accessories"
        }
    }

    /// SF Symbol shown on category chips and placeholder artwork.
    var symbolName: String {
        switch self {
        case .flower: "leaf.fill"
        case .prerolls: "flame.fill"
        case .vapes: "cloud.fill"
        case .edibles: "birthday.cake.fill"
        case .concentrates: "drop.fill"
        case .tinctures: "eyedropper.halffull"
        case .topicals: "hand.raised.fill"
        case .accessories: "bag.fill"
        }
    }
}

enum StrainType: String, Codable, CaseIterable, Identifiable, Hashable {
    case indica, sativa, hybrid, cbd

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .indica: "Indica"
        case .sativa: "Sativa"
        case .hybrid: "Hybrid"
        case .cbd: "CBD"
        }
    }
}

/// Commonly reported effects. Kept descriptive only; NJ rules prohibit health or medical claims.
enum Effect: String, Codable, CaseIterable, Identifiable, Hashable {
    case relaxed, sleepy, happy, euphoric, uplifted, creative, focused, energetic, calm, giggly, talkative, hungry

    var id: String { rawValue }

    var displayName: String { rawValue.capitalized }

    var symbolName: String {
        switch self {
        case .relaxed: "sofa.fill"
        case .sleepy: "moon.zzz.fill"
        case .happy: "face.smiling"
        case .euphoric: "sparkles"
        case .uplifted: "sun.max.fill"
        case .creative: "paintpalette.fill"
        case .focused: "scope"
        case .energetic: "bolt.fill"
        case .calm: "water.waves"
        case .giggly: "face.smiling.inverse"
        case .talkative: "bubble.left.and.bubble.right.fill"
        case .hungry: "fork.knife"
        }
    }
}

struct Potency: Codable, Hashable {
    enum Unit: String, Codable {
        /// Flower, pre-rolls, vapes, concentrates: percentage by weight.
        case percent
        /// Edibles, tinctures, topicals: milligrams per package.
        case milligrams
    }

    var thc: Double
    var cbd: Double
    var unit: Unit

    var thcLabel: String { "THC \(Self.format(thc, unit))" }
    var cbdLabel: String { "CBD \(Self.format(cbd, unit))" }

    private static func format(_ value: Double, _ unit: Unit) -> String {
        switch unit {
        case .percent: value.formatted(.number.precision(.fractionLength(0...1))) + "%"
        case .milligrams: value.formatted(.number.precision(.fractionLength(0))) + "mg"
        }
    }
}

/// One purchasable size of a product (e.g. 3.5g, 7g, 5-pack).
struct ProductVariant: Codable, Hashable, Identifiable {
    var id: String
    var label: String
    /// Weight in grams, used for NJ purchase-limit checks. `nil` for non-weighed items.
    var weightGrams: Double?
    var price: Decimal
    var salePrice: Decimal?
    var quantityAvailable: Int

    var effectivePrice: Decimal { salePrice ?? price }
    var isOnSale: Bool { salePrice != nil }
    var isInStock: Bool { quantityAvailable > 0 }
    var isLowStock: Bool { quantityAvailable > 0 && quantityAvailable <= 5 }
}

struct Product: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var brand: String
    var category: ProductCategory
    /// `nil` for accessories and other non-cannabis items.
    var strainType: StrainType?
    var summary: String
    var potency: Potency?
    var effects: [Effect]
    var terpenes: [String]
    var variants: [ProductVariant]
    /// Remote image from Dutchie. `nil` means show the placeholder artwork.
    var imageURL: URL?
    var isStaffPick: Bool
    var isNew: Bool

    var startingPrice: Decimal { variants.map(\.effectivePrice).min() ?? 0 }
    var isOnSale: Bool { variants.contains(where: \.isOnSale) }
    var isInStock: Bool { variants.contains(where: \.isInStock) }
    var defaultVariant: ProductVariant? { variants.first(where: \.isInStock) ?? variants.first }

    func variant(id: String) -> ProductVariant? {
        variants.first { $0.id == id }
    }
}
