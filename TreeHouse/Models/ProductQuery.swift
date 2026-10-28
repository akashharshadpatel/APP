import Foundation

enum ProductSort: String, CaseIterable, Identifiable, Hashable {
    case featured, priceLowToHigh, priceHighToLow, potencyHighToLow, name

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .featured: "Featured"
        case .priceLowToHigh: "Price: Low to High"
        case .priceHighToLow: "Price: High to Low"
        case .potencyHighToLow: "THC: High to Low"
        case .name: "Name (A–Z)"
        }
    }
}

/// Everything the menu can filter and sort by. Sent to `ProductService` so a real
/// backend can do the filtering server-side; the mock applies it locally with `apply(to:)`.
struct ProductQuery: Hashable {
    var category: ProductCategory?
    var searchText = ""
    var strainTypes: Set<StrainType> = []
    var maxPrice: Double?
    /// Minimum THC percentage. Only applies to percentage-labelled products.
    var minTHCPercent: Double?
    var onSaleOnly = false
    var inStockOnly = true
    var sort: ProductSort = .featured

    /// Number of filters (not counting category, search or sort) the customer has turned on.
    var activeFilterCount: Int {
        var count = strainTypes.count
        if maxPrice != nil { count += 1 }
        if minTHCPercent != nil { count += 1 }
        if onSaleOnly { count += 1 }
        return count
    }

    func apply(to products: [Product]) -> [Product] {
        let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        let filtered = products.filter { product in
            if let category, product.category != category { return false }
            if inStockOnly, !product.isInStock { return false }
            if onSaleOnly, !product.isOnSale { return false }
            if !strainTypes.isEmpty {
                guard let strain = product.strainType, strainTypes.contains(strain) else { return false }
            }
            if let maxPrice, product.startingPrice.doubleValue > maxPrice { return false }
            if let minTHCPercent {
                guard let potency = product.potency, potency.unit == .percent, potency.thc >= minTHCPercent else {
                    return false
                }
            }
            if !search.isEmpty {
                let haystack = [
                    product.name,
                    product.brand,
                    product.category.displayName,
                    product.strainType?.displayName ?? "",
                    product.effects.map(\.displayName).joined(separator: " "),
                    product.terpenes.joined(separator: " "),
                ].joined(separator: " ")
                if !haystack.localizedCaseInsensitiveContains(search) { return false }
            }
            return true
        }

        switch sort {
        case .featured:
            return filtered.sorted { lhs, rhs in
                if lhs.isStaffPick != rhs.isStaffPick { return lhs.isStaffPick }
                if lhs.isNew != rhs.isNew { return lhs.isNew }
                return lhs.name < rhs.name
            }
        case .priceLowToHigh:
            return filtered.sorted { $0.startingPrice < $1.startingPrice }
        case .priceHighToLow:
            return filtered.sorted { $0.startingPrice > $1.startingPrice }
        case .potencyHighToLow:
            return filtered.sorted { ($0.potency?.thc ?? 0) > ($1.potency?.thc ?? 0) }
        case .name:
            return filtered.sorted { $0.name.localizedCompare($1.name) == .orderedAscending }
        }
    }
}

extension Decimal {
    var doubleValue: Double { NSDecimalNumber(decimal: self).doubleValue }

    var currencyFormatted: String { formatted(.currency(code: "USD")) }
}
