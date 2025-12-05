//
//  GradientButton.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// A button with animated gradient background and scale effect on press
///
/// This component creates visually appealing buttons with gradient backgrounds
/// that can be fully customized. It includes built-in scale animation on press
/// and support for icons alongside text.
///
/// Example:
/// ```swift
/// GradientButton(
///     title: "Continue",
///     gradient: Gradient(colors: [.orange, .pink]),
///     icon: "arrow.right",
///     action: { print("Button tapped") }
/// )
/// ```
public struct GradientButton: View {
    let title: String
    let action: () -> Void

    var gradient: Gradient = .init(colors: [.blue, .purple])
    var startPoint: UnitPoint = .leading
    var endPoint: UnitPoint = .trailing
    var cornerRadius: CGFloat = 12
    var height: CGFloat?
    var isDisabled: Bool = false
    var icon: String?

    /// Creates a gradient button
    /// - Parameters:
    ///   - title: The button title text
    ///   - gradient: The gradient colors (default: blue to purple)
    ///   - startPoint: Gradient start point (default: leading)
    ///   - endPoint: Gradient end point (default: trailing)
    ///   - cornerRadius: Corner radius of the button (default: 12)
    ///   - height: Optional fixed height (default: nil, uses padding)
    ///   - isDisabled: Whether the button is disabled (default: false)
    ///   - icon: Optional SF Symbol name to display before the title
    ///   - action: Callback executed when the button is tapped
    public init(
        title: String,
        gradient: Gradient = Gradient(colors: [.blue, .purple]),
        startPoint: UnitPoint = .leading,
        endPoint: UnitPoint = .trailing,
        cornerRadius: CGFloat = 12,
        height: CGFloat? = nil,
        isDisabled: Bool = false,
        icon: String? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.gradient = gradient
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.cornerRadius = cornerRadius
        self.height = height
        self.isDisabled = isDisabled
        self.icon = icon
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.body.weight(.semibold))
                }

                Text(title)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .padding(.vertical, height == nil ? 16 : 0)
            .foregroundStyle(.white)
            .background(
                LinearGradient(
                    gradient: gradient,
                    startPoint: startPoint,
                    endPoint: endPoint
                )
            )
            .cornerRadius(cornerRadius)
            .opacity(isDisabled ? 0.6 : 1.0)
        }
        .buttonStyle(ScaleButtonStyle())
        .disabled(isDisabled)
    }
}

#Preview {
    VStack(spacing: 20) {
        GradientButton(
            title: "Continue",
            action: { print("Tapped") }
        )

        GradientButton(
            title: "Sign In",
            gradient: Gradient(colors: [.orange, .pink]),
            icon: "arrow.right",
            action: { print("Tapped") }
        )

        GradientButton(
            title: "Get Started",
            gradient: Gradient(colors: [.green, .blue]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing,
            action: { print("Tapped") }
        )

        GradientButton(
            title: "Disabled",
            isDisabled: true,
            action: { print("Tapped") }
        )
    }
    .padding()
}
