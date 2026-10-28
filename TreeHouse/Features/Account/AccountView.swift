import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "Account",
                systemImage: "person.crop.circle",
                description: Text("Sign in, rewards, favorites and store info will live here.")
            )
            .navigationTitle("Account")
        }
    }
}

#Preview {
    AccountView()
}
