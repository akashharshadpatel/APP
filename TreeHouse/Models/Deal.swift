import Foundation

struct Deal: Codable, Hashable, Identifiable {
    var id: String
    var title: String
    var subtitle: String
    /// Short eye-catching label, e.g. "20% OFF".
    var badge: String
    var details: String
    var finePrint: String
    var symbolName: String
    /// The deal applies to a whole category…
    var category: ProductCategory?
    /// …or to specific products.
    var productIDs: [String]
    var endsAt: Date?
}
