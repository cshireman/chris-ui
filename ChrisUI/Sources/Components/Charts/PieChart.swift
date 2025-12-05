//
//  PieChart.swift
//  ChrisUI
//
//  A pie chart for percentage breakdowns
//

import SwiftUI

/// A customizable pie chart for displaying percentage distributions
///
/// This component creates a pie chart that shows the proportion of each value
/// relative to the total, perfect for displaying category distributions.
///
/// Example:
/// ```swift
/// PieChart(
///     data: expensesByCategory,
///     value: \.amount,
///     label: \.category,
///     title: "Expense Distribution"
/// )
/// ```
public struct PieChart<DataPoint: Identifiable>: View {
    private let data: [DataPoint]
    private let value: KeyPath<DataPoint, Double>
    private let label: KeyPath<DataPoint, String>
    private let title: String?
    private let colors: [Color]

    @State private var selectedSlice: DataPoint.ID?

    /// Creates a pie chart
    /// - Parameters:
    ///   - data: Array of data points
    ///   - value: KeyPath to numeric value
    ///   - label: KeyPath to label text
    ///   - title: Optional chart title
    ///   - colors: Array of colors for slices
    public init(
        data: [DataPoint],
        value: KeyPath<DataPoint, Double>,
        label: KeyPath<DataPoint, String>,
        title: String? = nil,
        colors: [Color] = [.blue, .green, .orange, .red, .purple, .pink, .yellow, .cyan]
    ) {
        self.data = data
        self.value = value
        self.label = label
        self.title = title
        self.colors = colors
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
                        pieSlice(
                            for: item,
                            index: index,
                            total: total,
                            size: size
                        )
                    }
                }
                .frame(width: size, height: size)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
            .aspectRatio(1, contentMode: .fit)

            legendView
        }
        .padding()
    }

    // MARK: - Subviews

    private func pieSlice(for item: DataPoint, index: Int, total: Double, size: CGFloat) -> some View {
        let itemValue = item[keyPath: value]
        let percentage = itemValue / total
        let startAngle = calculateStartAngle(for: index, total: total)
        let endAngle = startAngle + Angle(degrees: 360 * percentage)

        return PieSliceShape(startAngle: startAngle, endAngle: endAngle)
            .fill(colors[index % colors.count])
            .overlay {
                if selectedSlice == item.id {
                    PieSliceShape(startAngle: startAngle, endAngle: endAngle)
                        .stroke(.white, lineWidth: 3)
                }
            }
            .scaleEffect(selectedSlice == item.id ? 1.05 : 1.0)
            .animation(.spring(response: 0.3), value: selectedSlice)
            .onTapGesture {
                withAnimation {
                    selectedSlice = selectedSlice == item.id ? nil : item.id
                }
            }
    }

    private var legendView: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(Array(data.enumerated()), id: \.element.id) { index, item in
                let total = data.reduce(0) { $0 + $1[keyPath: value] }
                let percentage = (item[keyPath: value] / total) * 100

                HStack {
                    Circle()
                        .fill(colors[index % colors.count])
                        .frame(width: 12, height: 12)

                    Text(item[keyPath: label])
                        .font(.subheadline)

                    Spacer()

                    Text(String(format: "%.1f%%", percentage))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
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

// MARK: - Pie Slice Shape

private struct PieSliceShape: Shape {
    let startAngle: Angle
    let endAngle: Angle

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

        path.move(to: center)
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        path.closeSubpath()

        return path
    }
}

#Preview {
    struct DataPoint: Identifiable {
        let id = UUID()
        let category: String
        let amount: Double
    }

    let data = [
        DataPoint(category: "Food", amount: 450),
        DataPoint(category: "Transport", amount: 280),
        DataPoint(category: "Entertainment", amount: 150),
        DataPoint(category: "Shopping", amount: 320),
        DataPoint(category: "Bills", amount: 600)
    ]

    return PieChart(
        data: data,
        value: \.amount,
        label: \.category,
        title: "Monthly Expenses"
    )
}
