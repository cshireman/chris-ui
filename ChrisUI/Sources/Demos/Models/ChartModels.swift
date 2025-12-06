//
//  ChartModels.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import Foundation

/// A simple data point model for chart demonstrations
struct ChartDataPoint: Identifiable {
    let id = UUID()
    let label: String
    let value: Double
}

/// A category-based data model for pie and donut charts
struct CategoryData: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
}

/// A simple value model for heat map demonstrations
struct HeatMapData: Identifiable {
    let id = UUID()
    let value: Double
}
