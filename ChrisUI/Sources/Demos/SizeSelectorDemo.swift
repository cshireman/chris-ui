//
//  SizeSelectorDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the SizeSelector component with different styles
struct SizeSelectorDemo: View {
    @State private var selectedSize1: String? = "M"
    @State private var selectedSize2: String?

    let clothingSizes = ["XS", "S", "M", "L", "XL", "XXL"]
    let shoeSizes = ["7", "8", "9", "10", "11", "12"]

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                VStack(alignment: .leading) {
                    Text("Clothing Sizes (Rounded)")
                        .font(.headline)

                    SizeSelector(
                        sizes: clothingSizes,
                        selectedSize: $selectedSize1,
                        unavailableSizes: ["XS", "XXL"],
                        style: .rounded
                    )

                    if let size = selectedSize1 {
                        Text("Selected: \(size)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                VStack(alignment: .leading) {
                    Text("Shoe Sizes (Square)")
                        .font(.headline)

                    SizeSelector(
                        sizes: shoeSizes,
                        selectedSize: $selectedSize2,
                        unavailableSizes: ["7", "12"],
                        style: .square
                    )

                    if let size = selectedSize2 {
                        Text("Selected: \(size)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Size Selector")
    }
}

#Preview {
    NavigationStack {
        SizeSelectorDemo()
    }
}
