//
//  ButtonStyles.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// A custom button style that scales down on press for tactile feedback
///
/// This style provides a subtle scale-down animation when the button is pressed,
/// giving users visual feedback that their tap was registered.
///
/// Example:
/// ```swift
/// Button("Tap Me") { }
///     .buttonStyle(.scale)
/// ```
public struct ScaleButtonStyle: ButtonStyle {
    var scaleAmount: CGFloat = 0.95

    /// Creates a scale button style
    /// - Parameter scaleAmount: The scale factor when pressed (default: 0.95)
    public init(scaleAmount: CGFloat = 0.95) {
        self.scaleAmount = scaleAmount
    }

    /// Creates the button view with scale animation
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

/// A custom button style that fades opacity on press for subtle feedback
///
/// This style provides a subtle opacity fade when the button is pressed,
/// offering a different visual feedback style than scaling.
///
/// Example:
/// ```swift
/// Button("Tap Me") { }
///     .buttonStyle(.fade)
/// ```
public struct FadeButtonStyle: ButtonStyle {
    var opacity: Double = 0.6

    /// Creates a fade button style
    /// - Parameter opacity: The opacity when pressed (default: 0.6)
    public init(opacity: Double = 0.6) {
        self.opacity = opacity
    }

    /// Creates the button view with fade animation
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? opacity : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

/// A custom button style combining both scale and opacity for enhanced feedback
///
/// This style provides the most pronounced visual feedback by combining both
/// scale and opacity animations, ideal for primary action buttons.
///
/// Example:
/// ```swift
/// Button("Submit") { }
///     .buttonStyle(.pressable)
/// ```
public struct PressableButtonStyle: ButtonStyle {
    var scaleAmount: CGFloat = 0.95
    var opacity: Double = 0.8

    /// Creates a pressable button style
    /// - Parameters:
    ///   - scaleAmount: The scale factor when pressed (default: 0.95)
    ///   - opacity: The opacity when pressed (default: 0.8)
    public init(scaleAmount: CGFloat = 0.95, opacity: Double = 0.8) {
        self.scaleAmount = scaleAmount
        self.opacity = opacity
    }

    /// Creates the button view with combined scale and fade animations
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .opacity(configuration.isPressed ? opacity : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

/// Convenient extension for applying ScaleButtonStyle
public extension ButtonStyle where Self == ScaleButtonStyle {
    /// Default scale button style with 0.95 scale factor
    static var scale: ScaleButtonStyle {
        ScaleButtonStyle()
    }

    /// Custom scale button style with specified scale factor
    /// - Parameter amount: The scale factor when pressed
    static func scale(_ amount: CGFloat) -> ScaleButtonStyle {
        ScaleButtonStyle(scaleAmount: amount)
    }
}

/// Convenient extension for applying FadeButtonStyle
public extension ButtonStyle where Self == FadeButtonStyle {
    /// Default fade button style with 0.6 opacity
    static var fade: FadeButtonStyle {
        FadeButtonStyle()
    }

    /// Custom fade button style with specified opacity
    /// - Parameter opacity: The opacity when pressed
    static func fade(_ opacity: Double) -> FadeButtonStyle {
        FadeButtonStyle(opacity: opacity)
    }
}

/// Convenient extension for applying PressableButtonStyle
public extension ButtonStyle where Self == PressableButtonStyle {
    /// Default pressable button style with scale and fade
    static var pressable: PressableButtonStyle {
        PressableButtonStyle()
    }
}

#Preview {
    VStack(spacing: 20) {
        Button("Scale Button") {
            print("Tapped")
        }
        .padding()
        .background(Color.blue)
        .foregroundStyle(.white)
        .cornerRadius(12)
        .buttonStyle(.scale)

        Button("Fade Button") {
            print("Tapped")
        }
        .padding()
        .background(Color.green)
        .foregroundStyle(.white)
        .cornerRadius(12)
        .buttonStyle(.fade)

        Button("Pressable Button") {
            print("Tapped")
        }
        .padding()
        .background(Color.orange)
        .foregroundStyle(.white)
        .cornerRadius(12)
        .buttonStyle(.pressable)
    }
    .padding()
}
