import SwiftUI

extension StrainType {
    var color: Color {
        switch self {
        case .indica: .strainIndica
        case .sativa: .strainSativa
        case .hybrid: .strainHybrid
        case .cbd: .strainCBD
        }
    }
}

/// Small colored capsule: "INDICA", "SATIVA", "HYBRID", "CBD".
struct StrainBadge: View {
    let strain: StrainType

    var body: some View {
        Text(strain.displayName.uppercased())
            .font(.caption2.weight(.bold))
            .tracking(0.5)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .foregroundStyle(strain.color)
            .background(strain.color.opacity(0.14), in: Capsule())
            .accessibilityLabel("\(strain.displayName) strain")
    }
}

/// Product image. Shows the Dutchie photo when available, otherwise a tinted placeholder
/// with the category's symbol.
struct ProductArtwork: View {
    let product: Product
    var cornerRadius: CGFloat = Theme.Radius.md
    var symbolFont: Font = .largeTitle

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [tint.opacity(0.32), tint.opacity(0.10)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Image(systemName: product.category.symbolName)
                .font(symbolFont)
                .foregroundStyle(tint)

            if let url = product.imageURL {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.clear
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .accessibilityHidden(true)
    }

    private var tint: Color { product.strainType?.color ?? .gray }
}

/// Price with an optional strikethrough original price when on sale.
struct PriceView: View {
    let price: Decimal
    var originalPrice: Decimal?
    var prefix: String?
    var font: Font = .headline

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            if let prefix {
                Text(prefix)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Text(price.currencyFormatted)
                .font(font)
                .foregroundStyle(originalPrice == nil ? Color.primary : Color.sale)
            if let originalPrice {
                Text(originalPrice.currencyFormatted)
                    .font(.subheadline)
                    .strikethrough()
                    .foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityText)
    }

    private var accessibilityText: String {
        let base = [prefix, price.currencyFormatted].compactMap { $0 }.joined(separator: " ")
        guard let originalPrice else { return base }
        return "\(base), on sale, was \(originalPrice.currencyFormatted)"
    }
}

/// "THC 24.6% · CBD 0.1%" line.
struct PotencyLine: View {
    let potency: Potency

    var body: some View {
        HStack(spacing: 6) {
            Text(potency.thcLabel)
            if potency.cbd >= 1 || (potency.unit == .milligrams && potency.cbd > 0) {
                Text("·").accessibilityHidden(true)
                Text(potency.cbdLabel)
            }
        }
        .font(.caption.weight(.medium))
        .foregroundStyle(.secondary)
    }
}
