//
//  GaugeViewDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the GaugeView component with adjustable values
struct GaugeViewDemo: View {
    @State private var value: Double = 75

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                GaugeView(
                    value: value,
                    range: 0...100,
                    label: "CPU Usage",
                    unit: "%",
                    color: .blue
                )
                .frame(height: 200)

                GaugeView(
                    value: value,
                    range: 0...100,
                    label: "Performance",
                    unit: "%",
                    color: .green,
                    lineWidth: 25
                )
                .frame(height: 220)

                VStack {
                    Text("Value: \(Int(value))")
                        .font(.headline)

                    Slider(value: $value, in: 0...100)
                        .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationTitle("Gauge View")
    }
}

#Preview {
    NavigationStack {
        GaugeViewDemo()
    }
}
