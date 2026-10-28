import SwiftUI

struct ShopView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "Shop",
                systemImage: "leaf",
                description: Text("The TreeHouse menu is coming in the next step.")
            )
            .navigationTitle("Shop")
        }
    }
}

#Preview {
    ShopView()
}
