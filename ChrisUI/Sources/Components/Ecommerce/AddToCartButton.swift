//
//  AddToCartButton.swift
//  ChrisUI
//
//  An animated button for adding items to cart
//

import SwiftUI

/// An animated button for adding products to shopping cart
///
/// This component provides visual feedback when items are added to the cart,
/// with a smooth animation and optional success state.
///
/// Example:
/// ```swift
/// AddToCartButton(isAdded: $isInCart) {
///     await addToCart(product)
/// }
/// ```
public struct AddToCartButton: View {
    @Binding private var isAdded: Bool
    private let action: () async -> Void
    private let style: ButtonStyleType

    @State private var isLoading = false

    /// Creates an add to cart button
    /// - Parameters:
    ///   - isAdded: Binding to track if item is in cart
    ///   - style: Visual style of the button
    ///   - action: Async action to perform when tapped
    public init(
        isAdded: Binding<Bool>,
        style: ButtonStyleType = .primary,
        action: @escaping () async -> Void
    ) {
        self._isAdded = isAdded
        self.style = style
        self.action = action
    }

    public var body: some View {
        Button {
            Task {
                isLoading = true
                await action()
                isLoading = false
                withAnimation(.spring(response: 0.3)) {
                    isAdded = true
                }
            }
        } label: {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                } else {
                    Image(systemName: isAdded ? "checkmark.circle.fill" : "cart.fill.badge.plus")
                        .font(.system(size: 18))

                    Text(isAdded ? "Added" : "Add to Cart")
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
        }
        .buttonStyle(CartButtonStyle(style: style, isAdded: isAdded))
        .disabled(isLoading || isAdded)
        .accessibilityLabel(isAdded ? "Added to cart" : "Add to cart")
    }

    // MARK: - Button Style Type

    public enum ButtonStyleType {
        case primary
        case secondary
        case minimal
    }
}

// MARK: - Cart Button Style

private struct CartButtonStyle: ButtonStyle {
    let style: AddToCartButton.ButtonStyleType
    let isAdded: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(backgroundColor)
            .foregroundStyle(foregroundColor)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3), value: configuration.isPressed)
            .animation(.spring(response: 0.3), value: isAdded)
    }

    private var backgroundColor: Color {
        if isAdded {
            return .green
        }
        switch style {
        case .primary:
            return .blue
        case .secondary:
            return Color(.systemGray5)
        case .minimal:
            return .clear
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary:
            return .white
        case .secondary:
            return .primary
        case .minimal:
            return .blue
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var isPrimaryAdded = false
        @State private var isSecondaryAdded = false
        @State private var isMinimalAdded = false

        var body: some View {
            VStack(spacing: 20) {
                AddToCartButton(isAdded: $isPrimaryAdded, style: .primary) {
                    try? await Task.sleep(for: .seconds(1))
                }

                AddToCartButton(isAdded: $isSecondaryAdded, style: .secondary) {
                    try? await Task.sleep(for: .seconds(1))
                }

                AddToCartButton(isAdded: $isMinimalAdded, style: .minimal) {
                    try? await Task.sleep(for: .seconds(1))
                }

                Button("Reset") {
                    isPrimaryAdded = false
                    isSecondaryAdded = false
                    isMinimalAdded = false
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
    }

    return PreviewWrapper()
}
