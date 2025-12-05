//
//  Extensions.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

// MARK: - View Extensions

/// Convenient view extensions for common SwiftUI operations
public extension View {
    /// Applies a modifier conditionally based on a boolean value
    ///
    /// This method allows you to conditionally apply view modifiers without
    /// breaking the modifier chain.
    ///
    /// Example:
    /// ```swift
    /// Text("Hello")
    ///     .if(isHighlighted) { view in
    ///         view.foregroundStyle(.red)
    ///     }
    /// ```
    /// - Parameters:
    ///   - condition: Boolean condition to evaluate
    ///   - transform: Modifier to apply if condition is true
    /// - Returns: The modified view if condition is true, otherwise the original view
    @ViewBuilder
    func `if`<Transform: View>(
        _ condition: Bool,
        transform: (Self) -> Transform
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    /// Applies one of two modifiers based on a boolean condition
    ///
    /// This method provides an if-else pattern for view modifiers.
    ///
    /// Example:
    /// ```swift
    /// Text("Status")
    ///     .if(isActive,
    ///         if: { $0.foregroundStyle(.green) },
    ///         else: { $0.foregroundStyle(.gray) }
    ///     )
    /// ```
    /// - Parameters:
    ///   - condition: Boolean condition to evaluate
    ///   - ifTransform: Modifier to apply if condition is true
    ///   - elseTransform: Modifier to apply if condition is false
    /// - Returns: The view with the appropriate modifier applied
    @ViewBuilder
    func `if`<TrueContent: View, FalseContent: View>(
        _ condition: Bool,
        if ifTransform: (Self) -> TrueContent,
        else elseTransform: (Self) -> FalseContent
    ) -> some View {
        if condition {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }

    /// Wraps the view in a container conditionally
    ///
    /// Useful for conditionally applying container views like NavigationLink or Button.
    ///
    /// Example:
    /// ```swift
    /// Image(systemName: "heart")
    ///     .wrappedIf(isInteractive) { content in
    ///         Button(action: {}) { content }
    ///     }
    /// ```
    /// - Parameters:
    ///   - condition: Whether to apply the wrapper
    ///   - wrapper: The wrapper view to apply if condition is true
    /// - Returns: The wrapped view if condition is true, otherwise the original view
    @ViewBuilder
    func wrappedIf<Wrapper: View>(
        _ condition: Bool,
        wrapper: (Self) -> Wrapper
    ) -> some View {
        if condition {
            wrapper(self)
        } else {
            self
        }
    }

    /// Applies a card-like appearance with background, corner radius, and shadow
    ///
    /// A convenience method for quickly styling views as cards.
    ///
    /// Example:
    /// ```swift
    /// VStack {
    ///     Text("Card Content")
    /// }
    /// .cardStyle(cornerRadius: 20, shadowRadius: 8)
    /// ```
    /// - Parameters:
    ///   - backgroundColor: The background color (default: system background)
    ///   - cornerRadius: The corner radius (default: 16)
    ///   - shadowRadius: The shadow blur radius (default: 4)
    /// - Returns: A view with card styling applied
    func cardStyle(
        backgroundColor: Color = Color(.systemBackground),
        cornerRadius: CGFloat = 16,
        shadowRadius: CGFloat = 4
    ) -> some View {
        background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(color: .black.opacity(0.1), radius: shadowRadius, y: 2)
    }

    /// Conditionally hides the view based on a boolean value
    ///
    /// Example:
    /// ```swift
    /// Text("Optional content")
    ///     .hidden(isContentHidden)
    /// ```
    /// - Parameter shouldHide: Whether to hide the view
    /// - Returns: The hidden view if true, otherwise the visible view
    @ViewBuilder
    func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide {
            hidden()
        } else {
            self
        }
    }
}

// MARK: - Color Extensions

/// Convenient color extensions for hex values and utility methods
public extension Color {
    /// Creates a color from a hexadecimal string
    ///
    /// Supports 3, 6, or 8 character hex strings (RGB, RRGGBB, or AARRGGBB).
    ///
    /// Example:
    /// ```swift
    /// Color(hex: "#FF5733")
    /// Color(hex: "3498db")
    /// Color(hex: "F39")
    /// ```
    /// - Parameter hex: Hexadecimal color string (with or without # prefix)
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    /// Returns the hexadecimal string representation of the color
    ///
    /// Example:
    /// ```swift
    /// let red = Color.red
    /// print(red.hexString) // "#FF0000"
    /// ```
    /// - Returns: Hex string in format #RRGGBB, or nil if conversion fails
    var hexString: String? {
        guard let components = cgColor?.components else { return nil }

        let r = Float(components[0])
        let g = Float(components.count > 1 ? components[1] : 0)
        let b = Float(components.count > 2 ? components[2] : 0)

        return String(format: "#%02lX%02lX%02lX",
                      lroundf(r * 255),
                      lroundf(g * 255),
                      lroundf(b * 255))
    }
}

// MARK: - String Extensions

/// Convenient string extensions for validation and formatting
public extension String {
    /// Validates if the string matches a valid email format
    ///
    /// Example:
    /// ```swift
    /// "user@example.com".isValidEmail // true
    /// "invalid-email".isValidEmail // false
    /// ```
    /// - Returns: true if the string is a valid email format
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }

    /// Truncates the string to a specified length with optional trailing text
    ///
    /// Example:
    /// ```swift
    /// "Hello World".truncated(to: 5) // "Hello..."
    /// "Short".truncated(to: 10) // "Short"
    /// ```
    /// - Parameters:
    ///   - length: Maximum length before truncation
    ///   - trailing: Text to append when truncated (default: "...")
    /// - Returns: The truncated string with trailing text if needed
    func truncated(to length: Int, trailing: String = "...") -> String {
        if count > length {
            return String(prefix(length)) + trailing
        }
        return self
    }
}
