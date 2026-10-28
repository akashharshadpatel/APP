import SwiftUI

struct OrdersView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "Orders",
                systemImage: "shippingbox",
                description: Text("Track pickups and reorder past favorites here.")
            )
            .navigationTitle("Orders")
        }
    }
}

#Preview {
    OrdersView()
}
