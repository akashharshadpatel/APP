import SwiftUI

enum AppTab: Hashable {
    case shop, deals, bag, orders, account
}

struct MainTabView: View {
    @Environment(\.services) private var services
    @State private var selectedTab: AppTab = .shop

    var body: some View {
        TabView(selection: $selectedTab) {
            ShopView(services: services)
                .tabItem { Label("Shop", systemImage: "leaf") }
                .tag(AppTab.shop)

            DealsView()
                .tabItem { Label("Deals", systemImage: "tag") }
                .tag(AppTab.deals)

            BagView()
                .tabItem { Label("Bag", systemImage: "bag") }
                .tag(AppTab.bag)

            OrdersView()
                .tabItem { Label("Orders", systemImage: "shippingbox") }
                .tag(AppTab.orders)

            AccountView()
                .tabItem { Label("Account", systemImage: "person.crop.circle") }
                .tag(AppTab.account)
        }
        .sensoryFeedback(.selection, trigger: selectedTab)
    }
}

#Preview {
    MainTabView()
}
