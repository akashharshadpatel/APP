import Foundation

// The real Dutchie integration goes here once API access is set up.
//
// How to connect it:
// 1. Create `final class DutchieService` (or an actor) that conforms to the protocols in
//    `Services/Protocols/Services.swift`: ProductService, CartService, OrderService, DealService,
//    LoyaltyService, StoreService and AuthService.
// 2. Map Dutchie's menu/products to `Product`, its checkout to `OrderService.placeOrder`, etc.
//    Keep API keys out of the app binary; route requests through your own server if Dutchie requires a secret.
// 3. In `App/AppEnvironment.swift`, change `AppServices.live` to use `DutchieService`.
//
// No view or view model needs to change.
