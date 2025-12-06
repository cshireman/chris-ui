//
//  DiscountBadgeDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the DiscountBadge component with different styles and sizes
struct DiscountBadgeDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack(alignment: .leading) {
                    Text("Product Card Example")
                        .font(.headline)

                    productCardExample
                }

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Text("Badge Sizes")
                        .font(.headline)

                    HStack(spacing: 12) {
                        DiscountBadge(discount: 50, style: .percentage, size: .small)
                        DiscountBadge(discount: 25, style: .percentage, size: .medium)
                        DiscountBadge(discount: 15, style: .percentage, size: .large)
                    }
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Badge Styles")
                        .font(.headline)

                    HStack(spacing: 12) {
                        DiscountBadge(text: "SALE", style: .sale, size: .medium)
                        DiscountBadge(text: "NEW", style: .new, size: .medium)
                        DiscountBadge(text: "HOT", style: .custom(color: .purple), size: .medium)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Discount Badge")
    }

    private var productCardExample: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.1))
                    .frame(height: 200)

                DiscountBadge(discount: 30)
                    .padding(12)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Wireless Headphones")
                    .font(.headline)

                HStack {
                    PriceTag(price: 69.99, originalPrice: 99.99)
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}

#Preview {
    NavigationStack {
        DiscountBadgeDemo()
    }
}
