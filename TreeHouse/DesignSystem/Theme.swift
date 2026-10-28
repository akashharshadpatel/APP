import SwiftUI
import UIKit

/// Spacing, corner radii and brand colors used across the app.
/// Change brand colors here (and in Assets > AccentColor) to re-skin the app.
enum Theme {
    enum Spacing {
        static let xxs: CGFloat = 4
        static let xs: CGFloat = 8
        static let sm: CGFloat = 12
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }

    enum Radius {
        static let sm: CGFloat = 10
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
    }
}

extension Color {
    /// Primary brand green (same value as the asset catalog AccentColor).
    static let brand = Color.accentColor
    static let brandDeep = Color(light: 0x1F4D33, dark: 0x8FD3A6)
    static let brandSoft = Color(light: 0xE6F2EA, dark: 0x1C2E23)
    static let warmNeutral = Color(light: 0xF6F2EA, dark: 0x1E1C19)

    static let screenBackground = Color(uiColor: .systemGroupedBackground)
    static let cardBackground = Color(uiColor: .secondarySystemGroupedBackground)

    static let strainIndica = Color(light: 0x6B4FBB, dark: 0xA48BEA)
    static let strainSativa = Color(light: 0xC96F1B, dark: 0xF2A65A)
    static let strainHybrid = Color(light: 0x2E7D4F, dark: 0x6FCF97)
    static let strainCBD = Color(light: 0x2F6FD1, dark: 0x6FA8F5)
    static let sale = Color(light: 0xC0392B, dark: 0xFF6B5E)

    /// A color that automatically switches between Light and Dark Mode.
    init(light: UInt32, dark: UInt32) {
        self.init(uiColor: UIColor { traits in
            UIColor(hex: traits.userInterfaceStyle == .dark ? dark : light)
        })
    }
}

private extension UIColor {
    convenience init(hex: UInt32) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
    }
}
