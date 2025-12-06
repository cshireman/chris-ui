//
//  HeatMapDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the HeatMap component with grid-based data
struct HeatMapDemo: View {
    let weekData = (0..<35).map { _ in
        HeatMapData(value: Double.random(in: 0...100))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack(alignment: .leading) {
                    Text("Activity Heat Map (Green)")
                        .font(.headline)

                    HeatMap(
                        data: weekData,
                        value: \.value,
                        columns: 7,
                        cellSize: 40,
                        colorScale: .green
                    )
                }

                VStack(alignment: .leading) {
                    Text("Performance Matrix (Blue)")
                        .font(.headline)

                    HeatMap(
                        data: weekData,
                        value: \.value,
                        columns: 5,
                        cellSize: 50,
                        colorScale: .blue,
                        showValues: true
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Heat Map")
    }
}

#Preview {
    NavigationStack {
        HeatMapDemo()
    }
}
