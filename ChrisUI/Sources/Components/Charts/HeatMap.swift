//
//  HeatMap.swift
//  ChrisUI
//
//  A grid-based data visualization heat map
//

import SwiftUI

/// A heat map for visualizing grid-based data with color intensity
///
/// This component creates a heat map where each cell's color intensity
/// represents its value, useful for activity calendars, correlation matrices, etc.
///
/// Example:
/// ```swift
/// HeatMap(
///     data: activityData,
///     columns: 7,
///     cellSize: 30,
///     colorScale: .green
/// )
/// ```
public struct HeatMap<DataPoint: Identifiable>: View {
    private let data: [DataPoint]
    private let value: KeyPath<DataPoint, Double>
    private let columns: Int
    private let cellSize: CGFloat
    private let spacing: CGFloat
    private let colorScale: ColorScale
    private let showValues: Bool

    /// Creates a heat map
    /// - Parameters:
    ///   - data: Array of data points
    ///   - value: KeyPath to numeric value
    ///   - columns: Number of columns in the grid
    ///   - cellSize: Size of each cell
    ///   - spacing: Spacing between cells
    ///   - colorScale: Color scheme for intensity
    ///   - showValues: Whether to show values in cells
    public init(
        data: [DataPoint],
        value: KeyPath<DataPoint, Double>,
        columns: Int = 7,
        cellSize: CGFloat = 30,
        spacing: CGFloat = 4,
        colorScale: ColorScale = .green,
        showValues: Bool = false
    ) {
        self.data = data
        self.value = value
        self.columns = columns
        self.cellSize = cellSize
        self.spacing = spacing
        self.colorScale = colorScale
        self.showValues = showValues
    }

    public var body: some View {
        let rows = (data.count + columns - 1) / columns
        let minValue = data.map { $0[keyPath: value] }.min() ?? 0
        let maxValue = data.map { $0[keyPath: value] }.max() ?? 1

        LazyVGrid(
            columns: Array(repeating: GridItem(.fixed(cellSize), spacing: spacing), count: columns),
            spacing: spacing
        ) {
            ForEach(data) { item in
                cell(for: item, minValue: minValue, maxValue: maxValue)
            }
        }
    }

    // MARK: - Subviews

    private func cell(for item: DataPoint, minValue: Double, maxValue: Double) -> some View {
        let itemValue = item[keyPath: value]
        let intensity = normalize(value: itemValue, min: minValue, max: maxValue)
        let cellColor = colorScale.color(for: intensity)

        return RoundedRectangle(cornerRadius: 4)
            .fill(cellColor)
            .frame(width: cellSize, height: cellSize)
            .overlay {
                if showValues {
                    Text(String(format: "%.0f", itemValue))
                        .font(.system(size: cellSize * 0.3))
                        .foregroundStyle(.primary)
                }
            }
    }

    // MARK: - Helper Methods

    private func normalize(value: Double, min: Double, max: Double) -> Double {
        guard max > min else { return 0 }
        return (value - min) / (max - min)
    }
}

// MARK: - Color Scale

/// Color scale options for heat map
public enum ColorScale {
    case green
    case blue
    case red
    case purple
    case gradient([Color])

    func color(for intensity: Double) -> Color {
        switch self {
        case .green:
            return Color.green.opacity(0.2 + intensity * 0.8)
        case .blue:
            return Color.blue.opacity(0.2 + intensity * 0.8)
        case .red:
            return Color.red.opacity(0.2 + intensity * 0.8)
        case .purple:
            return Color.purple.opacity(0.2 + intensity * 0.8)
        case .gradient(let colors):
            let index = Int(intensity * Double(colors.count - 1))
            return colors[min(index, colors.count - 1)]
        }
    }
}

#Preview {
    struct DataPoint: Identifiable {
        let id = UUID()
        let value: Double
    }

    // Generate sample data for a week view (7 columns × 5 rows)
    let weekData = (0..<35).map { _ in
        DataPoint(value: Double.random(in: 0...100))
    }

    return ScrollView {
        VStack(spacing: 30) {
            VStack(alignment: .leading) {
                Text("Activity Heat Map")
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
                Text("Performance Matrix")
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
}
