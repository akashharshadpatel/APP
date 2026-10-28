import SwiftUI

/// Every backend service the app uses. Screens receive these through the SwiftUI environment
/// (`@Environment(\.services)`), so they never know whether data is mock or real.
struct AppServices {
    var products: any ProductService
    var cart: any CartService
    var orders: any OrderService
    var deals: any DealService
    var loyalty: any LoyaltyService
    var store: any StoreService
    var auth: any AuthService
}

extension AppServices {
    /// The services the app runs with.
    /// ➜ When the Dutchie API is ready, this is the only line to change (e.g. `.dutchie`).
    static let live: AppServices = .mock

    static let mock: AppServices = {
        let mock = MockDutchieService()
        return AppServices(products: mock, cart: mock, orders: mock, deals: mock,
                           loyalty: mock, store: mock, auth: mock)
    }()
}

private struct AppServicesKey: EnvironmentKey {
    static let defaultValue: AppServices = .mock
}

extension EnvironmentValues {
    var services: AppServices {
        get { self[AppServicesKey.self] }
        set { self[AppServicesKey.self] = newValue }
    }
}
