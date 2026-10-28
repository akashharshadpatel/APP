import SwiftUI

struct ShopView: View {
    @State private var viewModel: ShopViewModel

    init(services: AppServices) {
        _viewModel = State(initialValue: ShopViewModel(productService: services.products))
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Shop")
                .task {
                    if viewModel.products.isEmpty { await viewModel.load() }
                }
                .refreshable { await viewModel.load() }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.products.isEmpty && viewModel.isLoading {
            ProgressView("Loading menu…")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let message = viewModel.errorMessage, viewModel.products.isEmpty {
            ContentUnavailableView {
                Label("Menu Unavailable", systemImage: "wifi.exclamationmark")
            } description: {
                Text(message)
            } actions: {
                Button("Try Again") { Task { await viewModel.load() } }
            }
        } else {
            List {
                ForEach(viewModel.sections, id: \.category) { section in
                    Section(section.category.displayName) {
                        ForEach(section.products) { product in
                            ProductRow(product: product)
                        }
                    }
                }
            }
        }
    }
}

struct ProductRow: View {
    let product: Product

    var body: some View {
        HStack(spacing: Theme.Spacing.sm) {
            ProductArtwork(product: product, cornerRadius: Theme.Radius.sm, symbolFont: .title2)
                .frame(width: 64, height: 64)

            VStack(alignment: .leading, spacing: 4) {
                Text(product.brand)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(product.name)
                    .font(.body.weight(.semibold))
                HStack(spacing: 6) {
                    if let strain = product.strainType { StrainBadge(strain: strain) }
                    if let potency = product.potency { PotencyLine(potency: potency) }
                }
            }

            Spacer(minLength: Theme.Spacing.xs)

            PriceView(
                price: product.startingPrice,
                originalPrice: product.isOnSale ? product.defaultVariant?.price : nil,
                font: .subheadline.weight(.semibold)
            )
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    ShopView(services: .mock)
}
