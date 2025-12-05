//
//  PriceTag.swift
//  ChrisUI
//
//  A formatted price display component
//

import SwiftUI

/// A component for displaying formatted prices with currency
///
/// This component handles price formatting with proper currency symbols,
/// decimal places, and optional styling for discounts.
///
/// Example:
/// ```swift
/// PriceTag(price: 99.99, currency: .usd)
/// PriceTag(price: 79.99, originalPrice: 99.99, currency: .usd)
/// ```
public struct PriceTag: View {
    private let price: Double
    private let originalPrice: Double?
    private let currency: Currency
    private let size: PriceSize
    private let showCents: Bool

    /// Creates a price tag
    /// - Parameters:
    ///   - price: Current price
    ///   - originalPrice: Optional original price (for showing discounts)
    ///   - currency: Currency type
    ///   - size: Text size
    ///   - showCents: Whether to show decimal places
    public init(
        price: Double,
        originalPrice: Double? = nil,
        currency: Currency = .usd,
        size: PriceSize = .medium,
        showCents: Bool = true
    ) {
        self.price = price
        self.originalPrice = originalPrice
        self.currency = currency
        self.size = size
        self.showCents = showCents
    }

    public var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Text(formattedPrice(price))
                .font(size.font)
                .fontWeight(.bold)
                .foregroundStyle(.primary)

            if let originalPrice = originalPrice, originalPrice > price {
                Text(formattedPrice(originalPrice))
                    .font(size.strikethroughFont)
                    .foregroundStyle(.secondary)
                    .strikethrough()
            }
        }
        .accessibilityLabel(priceAccessibilityLabel)
    }

    // MARK: - Helper Methods

    private func formattedPrice(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency.code
        formatter.currencySymbol = currency.symbol

        if !showCents {
            formatter.maximumFractionDigits = 0
        }

        return formatter.string(from: NSNumber(value: value)) ?? "\(currency.symbol)\(value)"
    }

    private var priceAccessibilityLabel: String {
        var label = "Price: \(formattedPrice(price))"
        if let originalPrice = originalPrice, originalPrice > price {
            label += ", originally \(formattedPrice(originalPrice))"
        }
        return label
    }

    // MARK: - Price Size

    public enum PriceSize {
        case small
        case medium
        case large
        case extraLarge

        var font: Font {
            switch self {
            case .small: return .caption
            case .medium: return .body
            case .large: return .title3
            case .extraLarge: return .title
            }
        }

        var strikethroughFont: Font {
            switch self {
            case .small: return .caption2
            case .medium: return .caption
            case .large: return .subheadline
            case .extraLarge: return .body
            }
        }
    }

    // MARK: - Currency

    public enum Currency {
        case usd
        case eur
        case gbp
        case jpy
        case cad
        case aud
        case custom(code: String, symbol: String)

        var code: String {
            switch self {
            case .usd: return "USD"
            case .eur: return "EUR"
            case .gbp: return "GBP"
            case .jpy: return "JPY"
            case .cad: return "CAD"
            case .aud: return "AUD"
            case .custom(let code, _): return code
            }
        }

        var symbol: String {
            switch self {
            case .usd: return "$"
            case .eur: return "€"
            case .gbp: return "£"
            case .jpy: return "¥"
            case .cad: return "C$"
            case .aud: return "A$"
            case .custom(_, let symbol): return symbol
            }
        }
    }
}

#Preview {
    VStack(spacing: 30) {
        VStack(alignment: .leading, spacing: 16) {
            Text("Standard Prices")
                .font(.headline)

            HStack {
                PriceTag(price: 19.99, size: .small)
                PriceTag(price: 49.99, size: .medium)
                PriceTag(price: 99.99, size: .large)
            }
        }

        Divider()

        VStack(alignment: .leading, spacing: 16) {
            Text("Discounted Prices")
                .font(.headline)

            VStack(alignment: .leading, spacing: 12) {
                PriceTag(price: 79.99, originalPrice: 99.99)
                PriceTag(price: 39.99, originalPrice: 59.99, size: .large)
                PriceTag(price: 149.99, originalPrice: 199.99, size: .extraLarge)
            }
        }

        Divider()

        VStack(alignment: .leading, spacing: 16) {
            Text("Different Currencies")
                .font(.headline)

            VStack(alignment: .leading, spacing: 12) {
                PriceTag(price: 99.99, currency: .usd)
                PriceTag(price: 89.99, currency: .eur)
                PriceTag(price: 79.99, currency: .gbp)
                PriceTag(price: 10500, currency: .jpy, showCents: false)
            }
        }
    }
    .padding()
}
