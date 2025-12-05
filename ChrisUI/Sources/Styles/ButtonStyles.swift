//
//  ButtonStyles.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// A custom button style with scale animation
public struct ScaleButtonStyle: ButtonStyle {
    var scaleAmount: CGFloat = 0.95

    public init(scaleAmount: CGFloat = 0.95) {
        self.scaleAmount = scaleAmount
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

/// A custom button style with opacity fade
public struct FadeButtonStyle: ButtonStyle {
    var opacity: Double = 0.6

    public init(opacity: Double = 0.6) {
        self.opacity = opacity
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? opacity : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

/// A custom button style with both scale and opacity
public struct PressableButtonStyle: ButtonStyle {
    var scaleAmount: CGFloat = 0.95
    var opacity: Double = 0.8

    public init(scaleAmount: CGFloat = 0.95, opacity: Double = 0.8) {
        self.scaleAmount = scaleAmount
        self.opacity = opacity
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .opacity(configuration.isPressed ? opacity : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == ScaleButtonStyle {
    public static var scale: ScaleButtonStyle {
        ScaleButtonStyle()
    }

    public static func scale(_ amount: CGFloat) -> ScaleButtonStyle {
        ScaleButtonStyle(scaleAmount: amount)
    }
}

extension ButtonStyle where Self == FadeButtonStyle {
    public static var fade: FadeButtonStyle {
        FadeButtonStyle()
    }

    public static func fade(_ opacity: Double) -> FadeButtonStyle {
        FadeButtonStyle(opacity: opacity)
    }
}

extension ButtonStyle where Self == PressableButtonStyle {
    public static var pressable: PressableButtonStyle {
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
