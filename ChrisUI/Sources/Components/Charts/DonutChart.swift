//
//  DonutChart.swift
//  ChrisUI
//
//  A donut chart for displaying ring-style metrics
//

import SwiftUI

/// A customizable donut chart with a hollow center
///
/// Similar to a pie chart but with a hollow center, often used for showing
/// progress or percentage completion with a central value display.
///
/// Example:
/// ```swift
/// DonutChart(
///     data: categoryData,
///     value: \.amount,
///     label: \.name,
///     centerText: "Total",
///     centerValue: "$2,500"
/// )
/// ```
public struct DonutChart<DataPoint: Identifiable>: View {
    private let data: [DataPoint]
    private let value: KeyPath<DataPoint, Double>
    private let label: KeyPath<DataPoint, String>
    private let title: String?
    private let centerText: String?
    private let centerValue: String?
    private let colors: [Color]
    private let lineWidth: CGFloat

    /// Creates a donut chart
    /// - Parameters:
    ///   - data: Array of data points
    ///   - value: KeyPath to numeric value
    ///   - label: KeyPath to label text
    ///   - title: Optional chart title
    ///   - centerText: Optional text in center
    ///   - centerValue: Optional value in center
    ///   - colors: Array of colors for segments
    ///   - lineWidth: Width of the donut ring
    public init(
        data: [DataPoint],
        value: KeyPath<DataPoint, Double>,
        label: KeyPath<DataPoint, String>,
        title: String? = nil,
        centerText: String? = nil,
        centerValue: String? = nil,
        colors: [Color] = [.blue, .green, .orange, .red, .purple, .pink],
        lineWidth: CGFloat = 40
    ) {
        self.data = data
        self.value = value
        self.label = label
        self.title = title
        self.centerText = centerText
        self.centerValue = centerValue
        self.colors = colors
        self.lineWidth = lineWidth
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let title = title {
                Text(title)
                    .font(.headline)
            }

            GeometryReader { geometry in
                let size = min(geometry.size.width, geometry.size.height)
                let total = data.reduce(0) { $0 + $1[keyPath: value] }

                ZStack {
                    ForEach(Array(data.enumerated()), id: \.element.id) { index, item in
                        donutSegment(
                            for: item,
                            index: index,
                            total: total,
                            size: size
                        )
                    }

                    centerContent
                }
                .frame(width: size, height: size)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
            .aspectRatio(1, contentMode: .fit)
        }
        .padding()
    }

    // MARK: - Subviews

    private func donutSegment(for item: DataPoint, index: Int, total: Double, size: CGFloat) -> some View {
        let itemValue = item[keyPath: value]
        let percentage = itemValue / total
        let startAngle = calculateStartAngle(for: index, total: total)
        let endAngle = startAngle + Angle(degrees: 360 * percentage)

        return DonutSegmentShape(
            startAngle: startAngle,
            endAngle: endAngle,
            lineWidth: lineWidth
        )
        .fill(colors[index % colors.count])
    }

    private var centerContent: some View {
        VStack(spacing: 4) {
            if let centerValue = centerValue {
                Text(centerValue)
                    .font(.system(size: 28, weight: .bold))
            }

            if let centerText = centerText {
                Text(centerText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    // MARK: - Helper Methods

    private func calculateStartAngle(for index: Int, total: Double) -> Angle {
        var angle: Double = 0
        for i in 0..<index {
            angle += (data[i][keyPath: value] / total) * 360
        }
        return Angle(degrees: angle - 90)
    }
}

// MARK: - Donut Segment Shape

private struct DonutSegmentShape: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let lineWidth: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )

        return path.strokedPath(.init(lineWidth: lineWidth, lineCap: .round))
    }
}

#Preview {
    struct DataPoint: Identifiable {
        let id = UUID()
        let category: String
        let amount: Double
    }

    let data = [
        DataPoint(category: "Completed", amount: 75),
        DataPoint(category: "In Progress", amount: 15),
        DataPoint(category: "Pending", amount: 10)
    ]

    return ScrollView {
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
}
