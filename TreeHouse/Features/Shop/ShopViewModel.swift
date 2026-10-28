import Foundation
import Observation

@MainActor
@Observable
final class ShopViewModel {
    private(set) var products: [Product] = []
    private(set) var isLoading = false
    var errorMessage: String?

    private let productService: any ProductService

    init(productService: any ProductService) {
        self.productService = productService
    }

    /// Products grouped by category, in menu order.
    var sections: [(category: ProductCategory, products: [Product])] {
        ProductCategory.allCases.compactMap { category -> (category: ProductCategory, products: [Product])? in
            let items = products.filter { $0.category == category }
            guard !items.isEmpty else { return nil }
            return (category: category, products: items)
        }
    }

    func load() async {
        isLoading = true
        defer { isLoading = false }
        do {
            products = try await productService.fetchProducts(matching: ProductQuery())
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
