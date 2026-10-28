import SwiftUI

struct BagView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "Bag",
                systemImage: "bag",
                description: Text("Items you add will appear here.")
            )
            .navigationTitle("Bag")
        }
    }
}

#Preview {
    BagView()
}
