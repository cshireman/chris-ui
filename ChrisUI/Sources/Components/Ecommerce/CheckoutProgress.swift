//
//  CheckoutProgress.swift
//  ChrisUI
//
//  A multi-step progress indicator for checkout flow
//

import SwiftUI

/// A step-by-step progress indicator for checkout processes
///
/// This component displays the current step in a multi-step checkout process,
/// helping users understand where they are in the flow.
///
/// Example:
/// ```swift
/// CheckoutProgress(
///     steps: ["Cart", "Shipping", "Payment", "Review"],
///     currentStep: 2
/// )
/// ```
public struct CheckoutProgress: View {
    private let steps: [String]
    private let currentStep: Int
    private let style: ProgressStyle

    /// Creates a checkout progress indicator
    /// - Parameters:
    ///   - steps: Array of step names
    ///   - currentStep: Current step index (0-based)
    ///   - style: Visual style of the progress indicator
    public init(
        steps: [String],
        currentStep: Int,
        style: ProgressStyle = .dots
    ) {
        self.steps = steps
        self.currentStep = min(max(currentStep, 0), steps.count - 1)
        self.style = style
    }

    public var body: some View {
        switch style {
        case .dots:
            dotsStyle
        case .numbers:
            numbersStyle
        case .bar:
            barStyle
        }
    }

    // MARK: - Style Implementations

    private var dotsStyle: some View {
        HStack(spacing: 0) {
            ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(dotColor(for: index))
                            .frame(width: 12, height: 12)

                        if index == currentStep {
                            Circle()
                                .stroke(Color.blue, lineWidth: 2)
                                .frame(width: 20, height: 20)
                        }
                    }

                    Text(step)
                        .font(.caption)
                        .fontWeight(index == currentStep ? .semibold : .regular)
                        .foregroundStyle(index <= currentStep ? .primary : .secondary)
                }
                .frame(maxWidth: .infinity)

                if index < steps.count - 1 {
                    Rectangle()
                        .fill(index < currentStep ? Color.blue : Color(.systemGray4))
                        .frame(height: 2)
                        .padding(.bottom, 24)
                }
            }
        }
        .accessibilityLabel("Step \(currentStep + 1) of \(steps.count): \(steps[currentStep])")
    }

    private var numbersStyle: some View {
        HStack(spacing: 0) {
            ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(numberBackgroundColor(for: index))
                            .frame(width: 32, height: 32)

                        if index < currentStep {
                            Image(systemName: "checkmark")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.white)
                        } else {
                            Text("\(index + 1)")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(index == currentStep ? .white : .secondary)
                        }
                    }

                    Text(step)
                        .font(.caption)
                        .fontWeight(index == currentStep ? .semibold : .regular)
                        .foregroundStyle(index <= currentStep ? .primary : .secondary)
                }
                .frame(maxWidth: .infinity)

                if index < steps.count - 1 {
                    Rectangle()
                        .fill(index < currentStep ? Color.blue : Color(.systemGray4))
                        .frame(height: 2)
                        .padding(.bottom, 32)
                }
            }
        }
        .accessibilityLabel("Step \(currentStep + 1) of \(steps.count): \(steps[currentStep])")
    }

    private var barStyle: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(steps[currentStep]) (\(currentStep + 1)/\(steps.count))")
                .font(.headline)

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(.systemGray5))
                        .frame(height: 8)

                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.blue)
                        .frame(
                            width: geometry.size.width * CGFloat(currentStep + 1) / CGFloat(steps.count),
                            height: 8
                        )
                        .animation(.easeInOut(duration: 0.3), value: currentStep)
                }
            }
            .frame(height: 8)

            HStack {
                ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                    Text(step)
                        .font(.caption)
                        .foregroundStyle(index == currentStep ? .primary : .secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .accessibilityLabel("Step \(currentStep + 1) of \(steps.count): \(steps[currentStep])")
    }

    // MARK: - Helper Methods

    private func dotColor(for index: Int) -> Color {
        if index < currentStep {
            return .blue
        } else if index == currentStep {
            return .blue
        } else {
            return Color(.systemGray4)
        }
    }

    private func numberBackgroundColor(for index: Int) -> Color {
        if index <= currentStep {
            return .blue
        } else {
            return Color(.systemGray5)
        }
    }

    // MARK: - Progress Style

    public enum ProgressStyle {
        case dots
        case numbers
        case bar
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var currentStep = 1
        let steps = ["Cart", "Shipping", "Payment", "Review"]

        var body: some View {
            ScrollView {
                VStack(spacing: 50) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Dots Style")
                            .font(.headline)

                        CheckoutProgress(
                            steps: steps,
                            currentStep: currentStep,
                            style: .dots
                        )
                    }

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Numbers Style")
                            .font(.headline)

                        CheckoutProgress(
                            steps: steps,
                            currentStep: currentStep,
                            style: .numbers
                        )
                    }

                    VStack(alignment: .leading, spacing: 20) {
                        Text("Bar Style")
                            .font(.headline)

                        CheckoutProgress(
                            steps: steps,
                            currentStep: currentStep,
                            style: .bar
                        )
                    }

                    HStack {
                        Button("Previous") {
                            if currentStep > 0 {
                                currentStep -= 1
                            }
                        }
                        .disabled(currentStep == 0)

                        Spacer()

                        Button("Next") {
                            if currentStep < steps.count - 1 {
                                currentStep += 1
                            }
                        }
                        .disabled(currentStep == steps.count - 1)
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
        }
    }

    return PreviewWrapper()
}
