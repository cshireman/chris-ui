//
//  AddToCartButtonDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the AddToCartButton component with different styles
struct AddToCartButtonDemo: View {
    @State private var isPrimaryAdded = false
    @State private var isSecondaryAdded = false
    @State private var isMinimalAdded = false

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack(alignment: .leading) {
                    Text("Primary Style")
                        .font(.headline)

                    AddToCartButton(isAdded: $isPrimaryAdded, style: .primary) {
                        try? await Task.sleep(for: .seconds(1))
                    }
                }

                VStack(alignment: .leading) {
                    Text("Secondary Style")
                        .font(.headline)

                    AddToCartButton(isAdded: $isSecondaryAdded, style: .secondary) {
                        try? await Task.sleep(for: .seconds(1))
                    }
                }

                VStack(alignment: .leading) {
                    Text("Minimal Style")
                        .font(.headline)

                    AddToCartButton(isAdded: $isMinimalAdded, style: .minimal) {
                        try? await Task.sleep(for: .seconds(1))
                    }
                }

                Button("Reset All") {
                    isPrimaryAdded = false
                    isSecondaryAdded = false
                    isMinimalAdded = false
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .navigationTitle("Add to Cart Button")
    }
}

#Preview {
    NavigationStack {
        AddToCartButtonDemo()
    }
}
