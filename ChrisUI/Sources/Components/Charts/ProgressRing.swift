//
//  ProgressRing.swift
//  ChrisUI
//
//  A circular progress indicator ring
//

import SwiftUI

/// A circular progress ring for displaying completion percentage
///
/// This component creates an animated circular progress indicator, commonly
/// used for showing goals, achievements, or task completion.
///
/// Example:
/// ```swift
/// ProgressRing(
///     progress: 0.75,
///     label: "75%",
///     subtitle: "Complete"
/// )
/// ```
public struct ProgressRing: View {
    private let progress: Double
    private let label: String?
    private let subtitle: String?
    private let lineWidth: CGFloat
    private let color: Color
    private let backgroundColor: Color

    @State private var animatedProgress: Double = 0

    /// Creates a progress ring
    /// - Parameters:
    ///   - progress: Progress value from 0.0 to 1.0
    ///   - label: Optional center label
    ///   - subtitle: Optional subtitle text
    ///   - lineWidth: Width of the ring
    ///   - color: Ring color
    ///   - backgroundColor: Background ring color
    public init(
        progress: Double,
        label: String? = nil,
        subtitle: String? = nil,
        lineWidth: CGFloat = 20,
        color: Color = .blue,
        backgroundColor: Color = Color.gray.opacity(0.2)
    ) {
        self.progress = min(max(progress, 0), 1)
        self.label = label
        self.subtitle = subtitle
        self.lineWidth = lineWidth
        self.color = color
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)

            ZStack {
                // Background ring
                Circle()
                    .stroke(backgroundColor, lineWidth: lineWidth)

                // Progress ring
                Circle()
                    .trim(from: 0, to: animatedProgress)
                    .stroke(
                        color,
                        style: StrokeStyle(
                            lineWidth: lineWidth,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))

                // Center content
                VStack(spacing: 4) {
                    if let label = label {
                        Text(label)
                            .font(.system(size: size * 0.15, weight: .bold))
                    }

                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.system(size: size * 0.08))
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .frame(width: size, height: size)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                animatedProgress = progress
            }
        }
        .onChange(of: progress) { oldValue, newValue in
            withAnimation(.easeInOut(duration: 0.5)) {
                animatedProgress = newValue
            }
        }
        .accessibilityLabel("\(Int(progress * 100))% complete")
    }
}

#Preview {
    VStack(spacing: 40) {
        ProgressRing(
            progress: 0.75,
            label: "75%",
            subtitle: "Complete",
            color: .blue
        )
        .frame(width: 200, height: 200)

        ProgressRing(
            progress: 0.45,
            label: "9/20",
            subtitle: "Tasks Done",
            lineWidth: 15,
            color: .green
        )
        .frame(width: 150, height: 150)

        ProgressRing(
            progress: 0.90,
            label: "90%",
            subtitle: "Goal Reached",
            lineWidth: 25,
            color: .orange
        )
        .frame(width: 180, height: 180)
    }
    .padding()
}
