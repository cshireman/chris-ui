//
//  LineChart.swift
//  ChrisUI
//
//  A line chart for displaying time series data
//

import SwiftUI
import Charts

/// A customizable line chart for time series data visualization
///
/// This component creates a line chart using SwiftUI Charts framework,
/// perfect for displaying trends over time.
///
/// Example:
/// ```swift
/// LineChart(
///     data: salesData,
///     xValue: \.date,
///     yValue: \.amount,
///     title: "Sales Over Time"
/// )
/// ```
@available(iOS 16.0, *)
public struct LineChart<DataPoint: Identifiable, X: Plottable, Y: Plottable>: View {
    private let data: [DataPoint]
    private let xValue: KeyPath<DataPoint, X>
    private let yValue: KeyPath<DataPoint, Y>
    private let title: String?
    private let lineColor: Color
    private let showPoints: Bool
    private let showGrid: Bool

    /// Creates a line chart
    /// - Parameters:
    ///   - data: Array of data points
    ///   - xValue: KeyPath to x-axis value
    ///   - yValue: KeyPath to y-axis value
    ///   - title: Optional chart title
    ///   - lineColor: Color of the line
    ///   - showPoints: Whether to show data point markers
    ///   - showGrid: Whether to show grid lines
    public init(
        data: [DataPoint],
        xValue: KeyPath<DataPoint, X>,
        yValue: KeyPath<DataPoint, Y>,
        title: String? = nil,
        lineColor: Color = .blue,
        showPoints: Bool = true,
        showGrid: Bool = true
    ) {
        self.data = data
        self.xValue = xValue
        self.yValue = yValue
        self.title = title
        self.lineColor = lineColor
        self.showPoints = showPoints
        self.showGrid = showGrid
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title = title {
                Text(title)
                    .font(.headline)
                    .padding(.horizontal)
            }

            Chart(data) { item in
                LineMark(
                    x: .value("X", item[keyPath: xValue]),
                    y: .value("Y", item[keyPath: yValue])
                )
                .foregroundStyle(lineColor)
                .interpolationMethod(.catmullRom)

                if showPoints {
                    PointMark(
                        x: .value("X", item[keyPath: xValue]),
                        y: .value("Y", item[keyPath: yValue])
                    )
                    .foregroundStyle(lineColor)
                }

                AreaMark(
                    x: .value("X", item[keyPath: xValue]),
                    y: .value("Y", item[keyPath: yValue])
                )
                .foregroundStyle(lineColor.opacity(0.1))
                .interpolationMethod(.catmullRom)
            }
            .frame(height: 200)
            .padding(.horizontal)
        }
        .accessibilityLabel(title ?? "Line chart")
    }
}

#Preview {
    struct DataPoint: Identifiable {
        let id = UUID()
        let day: String
        let value: Double
    }

    let data = [
        DataPoint(day: "Mon", value: 5),
        DataPoint(day: "Tue", value: 8),
        DataPoint(day: "Wed", value: 6),
        DataPoint(day: "Thu", value: 12),
        DataPoint(day: "Fri", value: 10),
        DataPoint(day: "Sat", value: 15),
        DataPoint(day: "Sun", value: 13)
    ]

    return ScrollView {
        VStack(spacing: 30) {
            if #available(iOS 16.0, *) {
                LineChart(
                    data: data,
                    xValue: \.day,
                    yValue: \.value,
                    title: "Weekly Activity"
                )

                LineChart(
                    data: data,
                    xValue: \.day,
                    yValue: \.value,
                    title: "Revenue Trend",
                    lineColor: .green,
                    showPoints: false
                )

                LineChart(
                    data: data,
                    xValue: \.day,
                    yValue: \.value,
                    title: "Temperature",
                    lineColor: .orange,
                    showGrid: false
                )
            } else {
                Text("Charts require iOS 16+")
            }
        }
        .padding(.vertical)
    }
}
