//
//  Sparkline.swift
//  ChrisUI
//
//  A compact trend line visualization
//

import SwiftUI

/// A compact sparkline chart for showing trends at a glance
///
/// This component creates a small, inline trend line perfect for dashboards
/// and summary views where space is limited.
///
/// Example:
/// ```swift
/// Sparkline(
///     data: recentSales,
///     lineColor: .green,
///     showFill: true
/// )
/// .frame(width: 100, height: 40)
/// ```
public struct Sparkline: View {
    private let data: [Double]
    private let lineColor: Color
    private let showFill: Bool
    private let showLastValue: Bool

    /// Creates a sparkline chart
    /// - Parameters:
    ///   - data: Array of numeric values
    ///   - lineColor: Color of the line
    ///   - showFill: Whether to fill area under line
    ///   - showLastValue: Whether to highlight last value
    public init(
        data: [Double],
        lineColor: Color = .blue,
        showFill: Bool = true,
        showLastValue: Bool = false
    ) {
        self.data = data
        self.lineColor = lineColor
        self.showFill = showFill
        self.showLastValue = showLastValue
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                if showFill {
                    sparklineFill(in: geometry.size)
                        .fill(lineColor.opacity(0.2))
                }

                sparklinePath(in: geometry.size)
                    .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))

                if showLastValue, let lastPoint = calculatePoints(in: geometry.size).last {
                    Circle()
                        .fill(lineColor)
                        .frame(width: 6, height: 6)
                        .position(x: lastPoint.x, y: lastPoint.y)
                }
            }
        }
        .accessibilityLabel("Trend line")
    }

    // MARK: - Helper Methods

    private func sparklinePath(in size: CGSize) -> Path {
        var path = Path()
        let points = calculatePoints(in: size)

        guard let firstPoint = points.first else { return path }

        path.move(to: firstPoint)
        for point in points.dropFirst() {
            path.addLine(to: point)
        }

        return path
    }

    private func sparklineFill(in size: CGSize) -> Path {
        var path = sparklinePath(in: size)
        let points = calculatePoints(in: size)

        guard let lastPoint = points.last else { return path }

        path.addLine(to: CGPoint(x: lastPoint.x, y: size.height))
        path.addLine(to: CGPoint(x: 0, y: size.height))
        path.closeSubpath()

        return path
    }

    private func calculatePoints(in size: CGSize) -> [CGPoint] {
        guard !data.isEmpty else { return [] }

        let minValue = data.min() ?? 0
        let maxValue = data.max() ?? 1
        let range = maxValue - minValue

        return data.enumerated().map { index, value in
            let x = size.width * CGFloat(index) / CGFloat(max(data.count - 1, 1))
            let normalizedValue = range > 0 ? (value - minValue) / range : 0.5
            let y = size.height * (1 - normalizedValue)
            return CGPoint(x: x, y: y)
        }
    }
}

#Preview {
    VStack(spacing: 30) {
        HStack {
            VStack(alignment: .leading) {
                Text("Revenue")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("$12,543")
                    .font(.title2)
                    .fontWeight(.bold)
            }

            Spacer()

            Sparkline(
                data: [5, 8, 6, 12, 10, 15, 13, 18, 16, 20],
                lineColor: .green
            )
            .frame(width: 100, height: 40)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)

        HStack {
            VStack(alignment: .leading) {
                Text("Active Users")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("1,234")
                    .font(.title2)
                    .fontWeight(.bold)
            }

            Spacer()

            Sparkline(
                data: [10, 12, 11, 9, 8, 10, 13, 15, 14, 16],
                lineColor: .blue,
                showLastValue: true
            )
            .frame(width: 100, height: 40)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)

        HStack {
            VStack(alignment: .leading) {
                Text("Performance")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("87%")
                    .font(.title2)
                    .fontWeight(.bold)
            }

            Spacer()

            Sparkline(
                data: [65, 70, 68, 75, 72, 78, 82, 80, 85, 87],
                lineColor: .orange,
                showFill: false,
                showLastValue: true
            )
            .frame(width: 100, height: 40)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
    .padding()
}
