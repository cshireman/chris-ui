//
//  PieChartDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the PieChart component with category breakdowns
struct PieChartDemo: View {
    let data = [
        CategoryData(category: "Food", amount: 450),
        CategoryData(category: "Transport", amount: 280),
        CategoryData(category: "Entertainment", amount: 150),
        CategoryData(category: "Shopping", amount: 320),
        CategoryData(category: "Bills", amount: 600)
    ]

    var body: some View {
        ScrollView {
            PieChart(
                data: data,
                value: \.amount,
                label: \.category,
                title: "Monthly Expenses"
            )
            .padding()
        }
        .navigationTitle("Pie Chart")
    }
}

#Preview {
    NavigationStack {
        PieChartDemo()
    }
}
