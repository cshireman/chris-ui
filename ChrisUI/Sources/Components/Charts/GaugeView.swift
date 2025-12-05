//
//  GaugeView.swift
//  ChrisUI
//
//  A speedometer-style gauge meter
//

import SwiftUI

/// A speedometer-style gauge for displaying metrics
///
/// This component creates a semi-circular gauge similar to a speedometer,
/// useful for displaying KPIs, performance metrics, or any ranged value.
///
/// Example:
/// ```swift
/// GaugeView(
///     value: 75,
///     range: 0...100,
///     label: "Performance",
///     unit: "%"
/// )
/// ```
public struct GaugeView: View {
    private let value: Double
    private let range: ClosedRange<Double>
    private let label: String?
    private let unit: String?
    private let color: Color
    private let lineWidth: CGFloat

    @State private var animatedValue: Double = 0

    /// Creates a gauge view
    /// - Parameters:
    ///   - value: Current value to display
    ///   - range: Min and max range for the gauge
    ///   - label: Optional label text
    ///   - unit: Optional unit text (e.g., "%", "mph")
    ///   - color: Gauge color
    ///   - lineWidth: Width of the gauge arc
    public init(
        value: Double,
        range: ClosedRange<Double> = 0...100,
        label: String? = nil,
        unit: String? = nil,
        color: Color = .blue,
        lineWidth: CGFloat = 20
    ) {
        self.value = min(max(value, range.lowerBound), range.upperBound)
        self.range = range
        self.label = label
        self.unit = unit
        self.color = color
        self.lineWidth = lineWidth
    }

    public var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)

            VStack {
                ZStack {
                    // Background arc
                    Circle()
                        .trim(from: 0, to: 0.75)
                        .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)
                        .rotationEffect(.degrees(135))

                    // Progress arc
                    Circle()
                        .trim(from: 0, to: normalizedValue * 0.75)
                        .stroke(
                            color,
                            style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                        )
                        .rotationEffect(.degrees(135))
                        .animation(.easeInOut(duration: 1.0), value: animatedValue)

                    // Center value
                    VStack(spacing: 4) {
                        Text(String(format: "%.0f", animatedValue))
                            .font(.system(size: size * 0.15, weight: .bold))

                        if let unit = unit {
                            Text(unit)
                                .font(.system(size: size * 0.06))
                                .foregroundStyle(.secondary)
                        }
                    }
                    .offset(y: size * 0.1)
                }
                .frame(width: size, height: size * 0.75)

                if let label = label {
                    Text(label)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .padding(.top, 8)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .aspectRatio(4/3, contentMode: .fit)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                animatedValue = value
            }
        }
        .onChange(of: value) { oldValue, newValue in
            withAnimation(.easeInOut(duration: 0.5)) {
                animatedValue = newValue
            }
        }
        .accessibilityLabel("\(label ?? "Gauge"): \(Int(value)) \(unit ?? "")")
    }

    // MARK: - Helper Properties

    private var normalizedValue: Double {
        let rangeSize = range.upperBound - range.lowerBound
        return (animatedValue - range.lowerBound) / rangeSize
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 40) {
            GaugeView(
                value: 75,
                range: 0...100,
                label: "CPU Usage",
                unit: "%",
                color: .blue
            )
            .frame(height: 200)

            GaugeView(
                value: 65,
                range: 0...120,
                label: "Speed",
                unit: "mph",
                color: .green,
                lineWidth: 25
            )
            .frame(height: 220)

            GaugeView(
                value: 42,
                range: 0...50,
                label: "Temperature",
                unit: "°C",
                color: .orange,
                lineWidth: 15
            )
            .frame(height: 180)
        }
        .padding()
    }
}
