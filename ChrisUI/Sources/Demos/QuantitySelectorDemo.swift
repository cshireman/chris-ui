//
//  QuantitySelectorDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the QuantitySelector component with different styles
struct QuantitySelectorDemo: View {
    @State private var quantity1 = 1
    @State private var quantity2 = 3
    @State private var quantity3 = 5

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Rounded Style")
                        .font(.headline)

                    QuantitySelector(quantity: $quantity1, style: .rounded)

                    Text("Current quantity: \(quantity1)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Square Style")
                        .font(.headline)

                    QuantitySelector(quantity: $quantity2, style: .square)

                    Text("Current quantity: \(quantity2)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Minimal Style")
                        .font(.headline)

                    QuantitySelector(quantity: $quantity3, style: .minimal) { newQuantity in
                        print("Quantity changed to: \(newQuantity)")
                    }

                    Text("Current quantity: \(quantity3)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Quantity Selector")
    }
}

#Preview {
    NavigationStack {
        QuantitySelectorDemo()
    }
}
