//
//  ProductGrid.swift
//  ChrisUI
//
//  A grid layout optimized for shopping items
//

import SwiftUI

/// A grid layout designed for displaying product catalogs
///
/// This component creates a responsive grid specifically optimized for
/// e-commerce product displays with consistent sizing and spacing.
///
/// Example:
/// ```swift
/// ProductGrid(products: store.products) { product in
///     ProductCard(product: product)
/// }
/// ```
public struct ProductGrid<Product: Identifiable, Content: View>: View {
    private let products: [Product]
    private let columns: Int
    private let spacing: CGFloat
    private let content: (Product) -> Content

    /// Creates a product grid
    /// - Parameters:
    ///   - products: Array of products to display
    ///   - columns: Number of columns (default: 2)
    ///   - spacing: Spacing between items
    ///   - content: ViewBuilder for each product
    public init(
        products: [Product],
        columns: Int = 2,
        spacing: CGFloat = 16,
        @ViewBuilder content: @escaping (Product) -> Content
    ) {
        self.products = products
        self.columns = columns
        self.spacing = spacing
        self.content = content
    }

    public var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: columns),
                spacing: spacing
            ) {
                ForEach(products) { product in
                    content(product)
                }
            }
            .padding(spacing)
        }
    }
}

#Preview {
    struct Product: Identifiable {
        let id = UUID()
        let name: String
        let price: Double
        let image: String
        let rating: Double
    }

    let products = [
        Product(name: "Wireless Headphones", price: 99.99, image: "headphones", rating: 4.5),
        Product(name: "Smart Watch", price: 299.99, image: "applewatch", rating: 4.8),
        Product(name: "Laptop Stand", price: 49.99, image: "laptopcomputer", rating: 4.2),
        Product(name: "USB-C Cable", price: 19.99, image: "cable.connector", rating: 4.0),
        Product(name: "Keyboard", price: 79.99, image: "keyboard", rating: 4.6),
        Product(name: "Mouse", price: 39.99, image: "computermouse", rating: 4.3)
    ]

    return ProductGrid(products: products) { product in
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.blue.opacity(0.1))
                .frame(height: 150)
                .overlay {
                    Image(systemName: product.image)
                        .font(.system(size: 40))
                        .foregroundStyle(.blue)
                }

            Text(product.name)
                .font(.headline)
                .lineLimit(2)

            HStack {
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundStyle(.yellow)
                Text(String(format: "%.1f", product.rating))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Text("$\(String(format: "%.2f", product.price))")
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
}
