//
//  BarChartDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the BarChart component with comparative data
@available(iOS 16.0, *)
struct BarChartDemo: View {
    let data = (0..<6).map { i in
        ChartDataPoint(label: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"][i], value: Double.random(in: 40...90))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                BarChart(
                    data: data,
                    xValue: \.label,
                    yValue: \.value,
                    title: "Monthly Sales",
                    barColor: .blue
                )

                BarChart(
                    data: data,
                    xValue: \.label,
                    yValue: \.value,
                    title: "Revenue Growth",
                    barColor: .green
                )
            }
            .padding()
        }
        .navigationTitle("Bar Chart")
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        NavigationStack {
            BarChartDemo()
        }
    } else {
        Text("Requires iOS 16+")
    }
}
