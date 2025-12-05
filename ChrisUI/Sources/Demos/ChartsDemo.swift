//
//  ChartsDemo.swift
//  ChrisUI
//
//  Demonstrations for all Charts & Visualizations components
//

import SwiftUI

// MARK: - Line Chart Demo

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

// MARK: - Bar Chart Demo

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

// MARK: - Pie Chart Demo

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

// MARK: - Donut Chart Demo

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

// MARK: - Progress Ring Demo

struct ProgressRingDemo: View {
    @State private var progress: Double = 0.75

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ProgressRing(
                    progress: progress,
                    label: "\(Int(progress * 100))%",
                    subtitle: "Complete",
                    color: .blue
                )
                .frame(height: 200)

                ProgressRing(
                    progress: progress,
                    label: "\(Int(progress * 20))/20",
                    subtitle: "Tasks Done",
                    lineWidth: 15,
                    color: .green
                )
                .frame(height: 180)

                VStack {
                    Text("Progress: \(Int(progress * 100))%")
                        .font(.headline)

                    Slider(value: $progress, in: 0...1)
                        .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationTitle("Progress Ring")
    }
}

// MARK: - Sparkline Demo

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

// MARK: - Gauge View Demo

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

// MARK: - Heat Map Demo

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

// MARK: - Supporting Models

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let label: String
    let value: Double
}

struct CategoryData: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
}

struct HeatMapData: Identifiable {
    let id = UUID()
    let value: Double
}

// MARK: - Previews

#Preview("Line Chart") {
    if #available(iOS 16.0, *) {
        NavigationStack {
            LineChartDemo()
        }
    } else {
        Text("Requires iOS 16+")
    }
}

#Preview("Bar Chart") {
    if #available(iOS 16.0, *) {
        NavigationStack {
            BarChartDemo()
        }
    } else {
        Text("Requires iOS 16+")
    }
}

#Preview("Pie Chart") {
    NavigationStack {
        PieChartDemo()
    }
}

#Preview("Donut Chart") {
    NavigationStack {
        DonutChartDemo()
    }
}

#Preview("Progress Ring") {
    NavigationStack {
        ProgressRingDemo()
    }
}

#Preview("Sparkline") {
    NavigationStack {
        SparklineDemo()
    }
}

#Preview("Gauge View") {
    NavigationStack {
        GaugeViewDemo()
    }
}

#Preview("Heat Map") {
    NavigationStack {
        HeatMapDemo()
    }
}
