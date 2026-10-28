import SwiftUI

struct DealsView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "Deals",
                systemImage: "tag",
                description: Text("Current deals will appear here.")
            )
            .navigationTitle("Deals")
        }
    }
}

#Preview {
    DealsView()
}
