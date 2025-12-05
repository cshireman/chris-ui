//
//  SizeSelector.swift
//  ChrisUI
//
//  A component for selecting product sizes
//

import SwiftUI

/// A selector component for choosing product sizes
///
/// This component displays available sizes and allows users to select one,
/// commonly used for clothing, shoes, and other sized products.
///
/// Example:
/// ```swift
/// SizeSelector(
///     sizes: ["XS", "S", "M", "L", "XL"],
///     selectedSize: $selectedSize
/// )
/// ```
public struct SizeSelector: View {
    private let sizes: [String]
    @Binding private var selectedSize: String?
    private let unavailableSizes: Set<String>
    private let style: SelectorStyle

    /// Creates a size selector
    /// - Parameters:
    ///   - sizes: Array of available sizes
    ///   - selectedSize: Binding to selected size
    ///   - unavailableSizes: Set of out-of-stock sizes
    ///   - style: Visual style of the selector
    public init(
        sizes: [String],
        selectedSize: Binding<String?>,
        unavailableSizes: Set<String> = [],
        style: SelectorStyle = .rounded
    ) {
        self.sizes = sizes
        self._selectedSize = selectedSize
        self.unavailableSizes = unavailableSizes
        self.style = style
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Size")
                .font(.subheadline)
                .fontWeight(.semibold)

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: style.columns),
                spacing: 12
            ) {
                ForEach(sizes, id: \.self) { size in
                    sizeButton(for: size)
                }
            }
        }
    }

    // MARK: - Subviews

    private func sizeButton(for size: String) -> some View {
        let isSelected = selectedSize == size
        let isUnavailable = unavailableSizes.contains(size)

        return Button {
            if !isUnavailable {
                selectedSize = isSelected ? nil : size
            }
        } label: {
            Text(size)
                .font(.subheadline)
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundStyle(buttonForegroundColor(isSelected: isSelected, isUnavailable: isUnavailable))
                .frame(height: style.buttonHeight)
                .frame(maxWidth: .infinity)
                .background(buttonBackground(isSelected: isSelected, isUnavailable: isUnavailable))
                .cornerRadius(style.cornerRadius)
                .overlay {
                    if isUnavailable {
                        RoundedRectangle(cornerRadius: style.cornerRadius)
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                            .foregroundStyle(.secondary)
                    } else if isSelected {
                        RoundedRectangle(cornerRadius: style.cornerRadius)
                            .stroke(Color.blue, lineWidth: 2)
                    } else {
                        RoundedRectangle(cornerRadius: style.cornerRadius)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    }
                }
        }
        .disabled(isUnavailable)
        .accessibilityLabel("Size \(size)")
        .accessibilityHint(isUnavailable ? "Out of stock" : isSelected ? "Selected" : "Tap to select")
    }

    // MARK: - Helper Methods

    private func buttonForegroundColor(isSelected: Bool, isUnavailable: Bool) -> Color {
        if isUnavailable {
            return .secondary
        }
        return isSelected ? .blue : .primary
    }

    private func buttonBackground(isSelected: Bool, isUnavailable: Bool) -> Color {
        if isUnavailable {
            return Color(.systemGray6)
        }
        return isSelected ? Color.blue.opacity(0.1) : Color(.systemBackground)
    }

    // MARK: - Selector Style

    public enum SelectorStyle {
        case rounded
        case square

        var buttonHeight: CGFloat {
            switch self {
            case .rounded, .square: return 44
            }
        }

        var cornerRadius: CGFloat {
            switch self {
            case .rounded: return 22
            case .square: return 8
            }
        }

        var columns: Int {
            switch self {
            case .rounded, .square: return 4
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedSize1: String? = "M"
        @State private var selectedSize2: String?

        let clothingSizes = ["XS", "S", "M", "L", "XL", "XXL"]
        let shoeSizes = ["7", "8", "9", "10", "11", "12"]

        var body: some View {
            ScrollView {
                VStack(spacing: 40) {
                    VStack(alignment: .leading) {
                        Text("Clothing Sizes (Rounded)")
                            .font(.headline)

                        SizeSelector(
                            sizes: clothingSizes,
                            selectedSize: $selectedSize1,
                            unavailableSizes: ["XS", "XXL"],
                            style: .rounded
                        )
                    }

                    VStack(alignment: .leading) {
                        Text("Shoe Sizes (Square)")
                            .font(.headline)

                        SizeSelector(
                            sizes: shoeSizes,
                            selectedSize: $selectedSize2,
                            unavailableSizes: ["7", "12"],
                            style: .square
                        )
                    }

                    if let size = selectedSize1 {
                        Text("Selected clothing size: \(size)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    if let size = selectedSize2 {
                        Text("Selected shoe size: \(size)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
            }
        }
    }

    return PreviewWrapper()
}
