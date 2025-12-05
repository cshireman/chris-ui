//
//  IconButton.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// A circular icon button with customizable styling and scale animation
///
/// A versatile icon button component that displays an SF Symbol in a circular
/// container. Commonly used for actions like favorites, bookmarks, close buttons,
/// or floating action buttons.
///
/// Example:
/// ```swift
/// IconButton(
///     icon: "heart.fill",
///     size: 56,
///     backgroundColor: .red,
///     foregroundColor: .white,
///     shadow: true,
///     action: { print("Favorite tapped") }
/// )
/// ```
public struct IconButton: View {
    let icon: String
    let action: () -> Void

    var size: CGFloat = 44
    var backgroundColor: Color = .init(.systemGray6)
    var foregroundColor: Color = .primary
    var borderColor: Color?
    var borderWidth: CGFloat = 0
    var shadow: Bool = false

    /// Creates a circular icon button
    /// - Parameters:
    ///   - icon: SF Symbol name for the icon
    ///   - size: Diameter of the circular button (default: 44)
    ///   - backgroundColor: Background color of the button (default: systemGray6)
    ///   - foregroundColor: Icon color (default: primary)
    ///   - borderColor: Optional border color (default: nil)
    ///   - borderWidth: Border width if borderColor is provided (default: 0)
    ///   - shadow: Whether to apply a shadow effect (default: false)
    ///   - action: Callback executed when the button is tapped
    public init(
        icon: String,
        size: CGFloat = 44,
        backgroundColor: Color = Color(.systemGray6),
        foregroundColor: Color = .primary,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        shadow: Bool = false,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.size = size
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shadow = shadow
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: size * 0.45))
                .foregroundStyle(foregroundColor)
                .frame(width: size, height: size)
                .background(backgroundColor)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(borderColor ?? .clear, lineWidth: borderWidth)
                )
                .shadow(color: shadow ? .black.opacity(0.1) : .clear, radius: 4, y: 2)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

#Preview {
    VStack(spacing: 20) {
        HStack(spacing: 16) {
            IconButton(icon: "heart", action: { print("Heart") })

            IconButton(
                icon: "heart.fill",
                backgroundColor: .red,
                foregroundColor: .white,
                action: { print("Heart filled") }
            )

            IconButton(
                icon: "bookmark",
                backgroundColor: .blue,
                foregroundColor: .white,
                shadow: true,
                action: { print("Bookmark") }
            )
        }

        HStack(spacing: 16) {
            IconButton(
                icon: "plus",
                size: 56,
                backgroundColor: .accentColor,
                foregroundColor: .white,
                action: { print("Add") }
            )

            IconButton(
                icon: "xmark",
                size: 32,
                backgroundColor: .clear,
                foregroundColor: .secondary,
                borderColor: Color(.systemGray4),
                borderWidth: 1,
                action: { print("Close") }
            )
        }

        HStack(spacing: 16) {
            IconButton(
                icon: "arrow.left",
                backgroundColor: .black,
                foregroundColor: .white,
                action: { print("Back") }
            )

            IconButton(
                icon: "ellipsis",
                action: { print("More") }
            )

            IconButton(
                icon: "gearshape",
                action: { print("Settings") }
            )
        }
    }
    .padding()
}
