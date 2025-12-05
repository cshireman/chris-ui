//
//  QuantitySelector.swift
//  ChrisUI
//
//  A plus/minus stepper for quantity selection
//

import SwiftUI

/// A stepper control for selecting quantities
///
/// This component provides an intuitive interface for adjusting quantities
/// with plus and minus buttons, commonly used in shopping carts.
///
/// Example:
/// ```swift
/// QuantitySelector(
///     quantity: $itemQuantity,
///     range: 1...99
/// )
/// ```
public struct QuantitySelector: View {
    @Binding private var quantity: Int
    private let range: ClosedRange<Int>
    private let style: SelectorStyle
    private let onChange: ((Int) -> Void)?

    /// Creates a quantity selector
    /// - Parameters:
    ///   - quantity: Binding to current quantity
    ///   - range: Valid range for quantity
    ///   - style: Visual style of the selector
    ///   - onChange: Optional callback when quantity changes
    public init(
        quantity: Binding<Int>,
        range: ClosedRange<Int> = 1...99,
        style: SelectorStyle = .rounded,
        onChange: ((Int) -> Void)? = nil
    ) {
        self._quantity = quantity
        self.range = range
        self.style = style
        self.onChange = onChange
    }

    public var body: some View {
        HStack(spacing: style.spacing) {
            decrementButton
            quantityDisplay
            incrementButton
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Quantity: \(quantity)")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                increment()
            case .decrement:
                decrement()
            @unknown default:
                break
            }
        }
    }

    // MARK: - Subviews

    private var decrementButton: some View {
        Button {
            decrement()
        } label: {
            Image(systemName: "minus")
                .font(.system(size: style.iconSize, weight: .semibold))
                .frame(width: style.buttonSize, height: style.buttonSize)
                .background(style.buttonBackground)
                .foregroundStyle(quantity <= range.lowerBound ? .secondary : .primary)
                .cornerRadius(style.cornerRadius)
        }
        .disabled(quantity <= range.lowerBound)
    }

    private var quantityDisplay: some View {
        Text("\(quantity)")
            .font(.system(size: style.fontSize, weight: .semibold))
            .frame(minWidth: style.displayWidth)
            .monospacedDigit()
    }

    private var incrementButton: some View {
        Button {
            increment()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: style.iconSize, weight: .semibold))
                .frame(width: style.buttonSize, height: style.buttonSize)
                .background(style.buttonBackground)
                .foregroundStyle(quantity >= range.upperBound ? .secondary : .primary)
                .cornerRadius(style.cornerRadius)
        }
        .disabled(quantity >= range.upperBound)
    }

    // MARK: - Actions

    private func increment() {
        guard quantity < range.upperBound else { return }
        quantity += 1
        onChange?(quantity)
    }

    private func decrement() {
        guard quantity > range.lowerBound else { return }
        quantity -= 1
        onChange?(quantity)
    }

    // MARK: - Selector Style

    public enum SelectorStyle {
        case rounded
        case square
        case minimal

        var buttonSize: CGFloat {
            switch self {
            case .rounded, .square: return 36
            case .minimal: return 32
            }
        }

        var iconSize: CGFloat {
            switch self {
            case .rounded, .square: return 14
            case .minimal: return 12
            }
        }

        var fontSize: CGFloat {
            switch self {
            case .rounded, .square: return 18
            case .minimal: return 16
            }
        }

        var displayWidth: CGFloat {
            switch self {
            case .rounded, .square: return 40
            case .minimal: return 30
            }
        }

        var spacing: CGFloat {
            switch self {
            case .rounded, .square: return 12
            case .minimal: return 8
            }
        }

        var cornerRadius: CGFloat {
            switch self {
            case .rounded: return 18
            case .square: return 8
            case .minimal: return 6
            }
        }

        var buttonBackground: Color {
            switch self {
            case .rounded, .square: return Color(.systemGray5)
            case .minimal: return Color(.systemGray6)
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var quantity1 = 1
        @State private var quantity2 = 3
        @State private var quantity3 = 5

        var body: some View {
            VStack(spacing: 30) {
                VStack(alignment: .leading) {
                    Text("Rounded Style")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    QuantitySelector(quantity: $quantity1, style: .rounded)
                }

                VStack(alignment: .leading) {
                    Text("Square Style")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    QuantitySelector(quantity: $quantity2, style: .square)
                }

                VStack(alignment: .leading) {
                    Text("Minimal Style")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    QuantitySelector(quantity: $quantity3, style: .minimal) { newQuantity in
                        print("Quantity changed to: \(newQuantity)")
                    }
                }
            }
            .padding()
        }
    }

    return PreviewWrapper()
}
