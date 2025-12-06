//
//  ProductGridDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the ProductGrid component with sample products
struct ProductGridDemo: View {
    let products = (0..<12).map { i in
        ProductData(
            name: "Product \(i + 1)",
            price: Double.random(in: 19.99...299.99),
            rating: Double.random(in: 3.5...5.0)
        )
    }

    var body: some View {
        ProductGrid(products: products) { product in
            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.1))
                    .frame(height: 150)
                    .overlay {
                        Image(systemName: "photo")
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
        .navigationTitle("Product Grid")
    }
}

#Preview {
    NavigationStack {
        ProductGridDemo()
    }
}
