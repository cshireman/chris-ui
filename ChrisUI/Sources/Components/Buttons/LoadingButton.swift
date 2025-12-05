//
//  LoadingButton.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// A button that displays loading state with a progress indicator
///
/// This component automatically shows a loading spinner when performing async operations.
/// It prevents multiple taps while loading and supports filled, outlined, and plain styles.
///
/// Example:
/// ```swift
/// struct MyView: View {
///     @State private var isLoading = false
///
///     var body: some View {
///         LoadingButton(
///             title: "Submit",
///             isLoading: $isLoading,
///             action: {
///                 isLoading = true
///                 Task {
///                     await performOperation()
///                     isLoading = false
///                 }
///             }
///         )
///     }
/// }
/// ```
public struct LoadingButton: View {
    let title: String
    let action: () -> Void

    @Binding var isLoading: Bool

    var style: ButtonStyleType = .filled
    var cornerRadius: CGFloat = 12
    var height: CGFloat?
    var icon: String?
    var backgroundColor: Color = .accentColor
    var foregroundColor: Color = .white

    /// Visual style options for the loading button
    public enum ButtonStyleType {
        case filled
        case outlined
        case plain
    }

    /// Creates a loading button
    /// - Parameters:
    ///   - title: The button title text
    ///   - isLoading: Binding to control the loading state
    ///   - style: Visual style of the button (default: filled)
    ///   - cornerRadius: Corner radius of the button (default: 12)
    ///   - height: Optional fixed height (default: nil)
    ///   - icon: Optional SF Symbol to display when not loading
    ///   - backgroundColor: Background color for filled style or border/text for outlined (default: accentColor)
    ///   - foregroundColor: Text color for filled style (default: white)
    ///   - action: Callback executed when the button is tapped (only when not loading)
    public init(
        title: String,
        isLoading: Binding<Bool>,
        style: ButtonStyleType = .filled,
        cornerRadius: CGFloat = 12,
        height: CGFloat? = nil,
        icon: String? = nil,
        backgroundColor: Color = .accentColor,
        foregroundColor: Color = .white,
        action: @escaping () -> Void
    ) {
        self.title = title
        _isLoading = isLoading
        self.style = style
        self.cornerRadius = cornerRadius
        self.height = height
        self.icon = icon
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.action = action
    }

    /// Determines the background color based on the button style
    private var buttonBackground: Color {
        switch style {
        case .filled:
            return backgroundColor
        case .outlined, .plain:
            return .clear
        }
    }

    /// Determines the foreground color based on the button style
    private var buttonForeground: Color {
        switch style {
        case .filled:
            return foregroundColor
        case .outlined, .plain:
            return backgroundColor
        }
    }

    public var body: some View {
        Button(action: {
            guard !isLoading else { return }
            action()
        }) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: buttonForeground))
                        .scaleEffect(0.9)
                } else {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.body.weight(.semibold))
                    }

                    Text(title)
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .padding(.vertical, height == nil ? 16 : 0)
            .foregroundStyle(buttonForeground)
            .background(buttonBackground)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(style == .outlined ? backgroundColor : .clear, lineWidth: 2)
            )
        }
        .disabled(isLoading)
        .opacity(isLoading ? 0.8 : 1.0)
    }
}

#Preview {
    struct LoadingButtonPreview: View {
        @State private var isLoading1 = false
        @State private var isLoading2 = false
        @State private var isLoading3 = false
        @State private var isLoading4 = false

        var body: some View {
            VStack(spacing: 20) {
                LoadingButton(
                    title: "Submit",
                    isLoading: $isLoading1,
                    action: {
                        isLoading1 = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoading1 = false
                        }
                    }
                )

                LoadingButton(
                    title: "Save Changes",
                    isLoading: $isLoading2,
                    style: .outlined,
                    backgroundColor: .blue,
                    action: {
                        isLoading2 = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoading2 = false
                        }
                    }
                )

                LoadingButton(
                    title: "Upload",
                    isLoading: $isLoading3,
                    icon: "arrow.up.circle",
                    backgroundColor: .green,
                    action: {
                        isLoading3 = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoading3 = false
                        }
                    }
                )

                LoadingButton(
                    title: "Loading State",
                    isLoading: $isLoading4,
                    backgroundColor: .orange,
                    action: {}
                )
                .onAppear {
                    isLoading4 = true
                }
            }
            .padding()
        }
    }

    return LoadingButtonPreview()
}
