//
//  ColorSwatchDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the ColorSwatch component with different styles
struct ColorSwatchDemo: View {
    @State private var selectedColor1: UUID?
    @State private var selectedColor2: UUID?
    @State private var selectedColor3: UUID?

    let colors = [
        ColorOption(name: "Black", color: .black),
        ColorOption(name: "White", color: .white),
        ColorOption(name: "Blue", color: .blue),
        ColorOption(name: "Red", color: .red),
        ColorOption(name: "Green", color: .green),
        ColorOption(name: "Purple", color: .purple)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                VStack(alignment: .leading) {
                    Text("Circle Style (Small)")
                        .font(.headline)

                    ColorSwatch(
                        colors: colors,
                        selectedColor: $selectedColor1,
                        size: .small,
                        style: .circle
                    )
                }

                VStack(alignment: .leading) {
                    Text("Rounded Style (Medium)")
                        .font(.headline)

                    ColorSwatch(
                        colors: colors,
                        selectedColor: $selectedColor2,
                        size: .medium,
                        style: .rounded
                    )
                }

                VStack(alignment: .leading) {
                    Text("Square Style (Large)")
                        .font(.headline)

                    ColorSwatch(
                        colors: colors,
                        selectedColor: $selectedColor3,
                        size: .large,
                        style: .square
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Color Swatch")
    }
}

#Preview {
    NavigationStack {
        ColorSwatchDemo()
    }
}
