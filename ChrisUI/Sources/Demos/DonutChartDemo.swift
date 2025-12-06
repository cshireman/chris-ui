//
//  DonutChartDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the DonutChart component with ring-style metrics
struct DonutChartDemo: View {
    let data = [
        CategoryData(category: "Completed", amount: 75),
        CategoryData(category: "In Progress", amount: 15),
        CategoryData(category: "Pending", amount: 10)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                DonutChart(
                    data: data,
                    value: \.amount,
                    label: \.category,
                    title: "Project Status",
                    centerText: "Total",
                    centerValue: "100"
                )

                DonutChart(
                    data: data,
                    value: \.amount,
                    label: \.category,
                    centerText: "Complete",
                    centerValue: "75%",
                    lineWidth: 30
                )
            }
            .padding()
        }
        .navigationTitle("Donut Chart")
    }
}

#Preview {
    NavigationStack {
        DonutChartDemo()
    }
}
