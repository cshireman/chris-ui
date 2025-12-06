//
//  SparklineDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the Sparkline component in metric cards
struct SparklineDemo: View {
    let data1 = [5.0, 8, 6, 12, 10, 15, 13, 18, 16, 20]
    let data2 = [10.0, 12, 11, 9, 8, 10, 13, 15, 14, 16]
    let data3 = [65.0, 70, 68, 75, 72, 78, 82, 80, 85, 87]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                metricCard(
                    title: "Revenue",
                    value: "$12,543",
                    data: data1,
                    color: .green
                )

                metricCard(
                    title: "Active Users",
                    value: "1,234",
                    data: data2,
                    color: .blue,
                    showLastValue: true
                )

                metricCard(
                    title: "Performance",
                    value: "87%",
                    data: data3,
                    color: .orange,
                    showFill: false
                )
            }
            .padding()
        }
        .navigationTitle("Sparkline")
    }

    private func metricCard(
        title: String,
        value: String,
        data: [Double],
        color: Color,
        showFill: Bool = true,
        showLastValue: Bool = false
    ) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
            }

            Spacer()

            Sparkline(
                data: data,
                lineColor: color,
                showFill: showFill,
                showLastValue: showLastValue
            )
            .frame(width: 100, height: 40)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    NavigationStack {
        SparklineDemo()
    }
}
