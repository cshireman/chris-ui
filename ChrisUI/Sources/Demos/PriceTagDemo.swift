//
//  PriceTagDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the PriceTag component with various configurations
struct PriceTagDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Standard Prices")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        PriceTag(price: 19.99, size: .small)
                        PriceTag(price: 49.99, size: .medium)
                        PriceTag(price: 99.99, size: .large)
                        PriceTag(price: 299.99, size: .extraLarge)
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Text("Discounted Prices")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        PriceTag(price: 79.99, originalPrice: 99.99)
                        PriceTag(price: 39.99, originalPrice: 59.99, size: .large)
                        PriceTag(price: 149.99, originalPrice: 199.99, size: .extraLarge)
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Text("Different Currencies")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        PriceTag(price: 99.99, currency: .usd)
                        PriceTag(price: 89.99, currency: .eur)
                        PriceTag(price: 79.99, currency: .gbp)
                        PriceTag(price: 10500, currency: .jpy, showCents: false)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Price Tag")
    }
}

#Preview {
    NavigationStack {
        PriceTagDemo()
    }
}
