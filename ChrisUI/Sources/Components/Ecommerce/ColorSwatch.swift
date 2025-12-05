//
//  ColorSwatch.swift
//  ChrisUI
//
//  A component for selecting product colors
//

import SwiftUI

/// A color swatch selector for product variations
///
/// This component displays available colors as swatches and allows
/// users to select their preferred color option.
///
/// Example:
/// ```swift
/// ColorSwatch(
///     colors: [.black, .white, .blue, .red],
///     selectedColor: $selectedColor
/// )
/// ```
public struct ColorSwatch: View {
    private let colors: [ColorOption]
    @Binding private var selectedColor: UUID?
    private let size: SwatchSize
    private let style: SwatchStyle

    /// Creates a color swatch selector
    /// - Parameters:
    ///   - colors: Array of color options
    ///   - selectedColor: Binding to selected color ID
    ///   - size: Size of each swatch
    ///   - style: Visual style of swatches
    public init(
        colors: [ColorOption],
        selectedColor: Binding<UUID?>,
        size: SwatchSize = .medium,
        style: SwatchStyle = .circle
    ) {
        self.colors = colors
        self._selectedColor = selectedColor
        self.size = size
        self.style = style
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let selected = colors.first(where: { $0.id == selectedColor }) {
                Text("Color: \(selected.name)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            } else {
                Text("Color")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(colors) { colorOption in
                        swatchButton(for: colorOption)
                    }
                }
            }
        }
    }

    // MARK: - Subviews

    private func swatchButton(for colorOption: ColorOption) -> some View {
        let isSelected = selectedColor == colorOption.id

        return Button {
            withAnimation(.spring(response: 0.3)) {
                selectedColor = colorOption.id
            }
        } label: {
            ZStack {
                style.shape
                    .fill(colorOption.color)
                    .frame(width: size.dimension, height: size.dimension)
                    .overlay {
                        if colorOption.color == .white || colorOption.color.isLightColor {
                            style.shape
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        }
                    }

                if isSelected {
                    style.shape
                        .stroke(Color.blue, lineWidth: 3)
                        .frame(width: size.dimension + 6, height: size.dimension + 6)
                }

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: size.checkmarkSize, weight: .bold))
                        .foregroundStyle(colorOption.color.isLightColor ? .black : .white)
                }
            }
        }
        .accessibilityLabel(colorOption.name)
        .accessibilityHint(isSelected ? "Selected" : "Tap to select")
    }

    // MARK: - Swatch Size

    public enum SwatchSize {
        case small
        case medium
        case large

        var dimension: CGFloat {
            switch self {
            case .small: return 32
            case .medium: return 44
            case .large: return 56
            }
        }

        var checkmarkSize: CGFloat {
            switch self {
            case .small: return 12
            case .medium: return 16
            case .large: return 20
            }
        }
    }

    // MARK: - Swatch Style

    public enum SwatchStyle {
        case circle
        case square
        case rounded

        var shape: AnyShape {
            switch self {
            case .circle:
                return AnyShape(Circle())
            case .square:
                return AnyShape(Rectangle())
            case .rounded:
                return AnyShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

// MARK: - Color Option

/// Represents a selectable color option
public struct ColorOption: Identifiable {
    public let id = UUID()
    public let name: String
    public let color: Color

    public init(name: String, color: Color) {
        self.name = name
        self.color = color
    }
}

// MARK: - Type-erased Shape

struct AnyShape: Shape {
    let _path: (CGRect) -> Path

    init<S: Shape>(_ shape: S) {
        _path = { rect in
            shape.path(in: rect)
        }
    }

    func path(in rect: CGRect) -> Path {
        _path(rect)
    }
}

// MARK: - Color Extension

extension Color {
    var isLightColor: Bool {
        #if canImport(UIKit)
        guard let components = UIColor(self).cgColor.components else { return false }
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        return brightness > 0.7
        #else
        return false
        #endif
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedColor1: UUID?
        @State private var selectedColor2: UUID?
        @State private var selectedColor3: UUID?

        let colors = [
            ColorOption(name: "Black", color: .black),
            ColorOption(name: "White", color: .white),
            ColorOption(name: "Blue", color: .blue),
            ColorOption(name: "Red", color: .red),
            ColorOption(name: "Green", color: .green),
            ColorOption(name: "Purple", color: .purple)
        ]

        var body: some View {
            ScrollView {
                VStack(spacing: 40) {
                    ColorSwatch(
                        colors: colors,
                        selectedColor: $selectedColor1,
                        size: .small,
                        style: .circle
                    )

                    ColorSwatch(
                        colors: colors,
                        selectedColor: $selectedColor2,
                        size: .medium,
                        style: .rounded
                    )

                    ColorSwatch(
                        colors: colors,
                        selectedColor: $selectedColor3,
                        size: .large,
                        style: .square
                    )
                }
                .padding()
            }
        }
    }

    return PreviewWrapper()
}
