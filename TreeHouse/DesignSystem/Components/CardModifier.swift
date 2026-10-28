import SwiftUI

struct CardModifier: ViewModifier {
    var padding: CGFloat = Theme.Spacing.md

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: Theme.Radius.md, style: .continuous)
                    .fill(Color.cardBackground)
            )
    }
}

extension View {
    /// Wraps the view in a rounded card that adapts to Light and Dark Mode.
    func cardStyle(padding: CGFloat = Theme.Spacing.md) -> some View {
        modifier(CardModifier(padding: padding))
    }
}
