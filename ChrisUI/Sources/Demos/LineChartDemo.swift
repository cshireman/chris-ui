//
//  LineChartDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the LineChart component with time series data
@available(iOS 16.0, *)
struct LineChartDemo: View {
    let data = (0..<7).map { i in
        ChartDataPoint(label: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][i], value: Double.random(in: 5...20))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                LineChart(
                    data: data,
                    xValue: \.label,
                    yValue: \.value,
                    title: "Weekly Activity",
                    lineColor: .blue
                )

                LineChart(
                    data: data,
                    xValue: \.label,
                    yValue: \.value,
                    title: "Revenue Trend",
                    lineColor: .green,
                    showPoints: false
                )
            }
            .padding()
        }
        .navigationTitle("Line Chart")
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        NavigationStack {
            LineChartDemo()
        }
    } else {
        Text("Requires iOS 16+")
    }
}
