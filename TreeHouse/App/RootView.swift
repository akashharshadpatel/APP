import SwiftUI

/// The first view on screen. Later steps add the age gate and NJ notice in front of the tabs.
struct RootView: View {
    var body: some View {
        MainTabView()
    }
}

#Preview {
    RootView()
}
