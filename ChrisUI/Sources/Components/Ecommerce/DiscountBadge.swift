//
//  DiscountBadge.swift
//  ChrisUI
//
//  A badge showing sale or discount information
//

import SwiftUI

/// A badge component for displaying discount information
///
/// This component creates an eye-catching badge to highlight sales,
/// discounts, or special offers on products.
///
/// Example:
/// ```swift
/// DiscountBadge(discount: 25, style: .percentage)
/// DiscountBadge(text: "SALE", style: .custom(color: .red))
/// ```
public struct DiscountBadge: View {
    private let text: String
    private let style: BadgeStyle
    private let size: BadgeSize

    /// Creates a discount badge from percentage
    /// - Parameters:
    ///   - discount: Discount percentage
    ///   - style: Visual style of the badge
    ///   - size: Size of the badge
    public init(
        discount: Int,
        style: BadgeStyle = .percentage,
        size: BadgeSize = .medium
    ) {
        self.text = "-\(discount)%"
        self.style = style
        self.size = size
    }

    /// Creates a discount badge with custom text
    /// - Parameters:
    ///   - text: Custom badge text
    ///   - style: Visual style of the badge
    ///   - size: Size of the badge
    public init(
        text: String,
        style: BadgeStyle = .sale,
        size: BadgeSize = .medium
    ) {
        self.text = text
        self.style = style
        self.size = size
    }

    public var body: some View {
        Text(text)
            .font(size.font)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.horizontal, size.horizontalPadding)
            .padding(.vertical, size.verticalPadding)
            .background(style.backgroundColor)
            .cornerRadius(size.cornerRadius)
            .accessibilityLabel("\(text) discount")
    }

    // MARK: - Badge Style

    public enum BadgeStyle {
        case percentage
        case sale
        case new
        case custom(color: Color)

        var backgroundColor: Color {
            switch self {
            case .percentage: return .red
            case .sale: return .orange
            case .new: return .blue
            case .custom(let color): return color
            }
        }
    }

    // MARK: - Badge Size

    public enum BadgeSize {
        case small
        case medium
        case large

        var font: Font {
            switch self {
            case .small: return .caption2
            case .medium: return .caption
            case .large: return .subheadline
            }
        }

        var horizontalPadding: CGFloat {
            switch self {
            case .small: return 6
            case .medium: return 8
            case .large: return 10
            }
        }

        var verticalPadding: CGFloat {
            switch self {
            case .small: return 2
            case .medium: return 4
            case .large: return 6
            }
        }

        var cornerRadius: CGFloat {
            switch self {
            case .small: return 4
            case .medium: return 6
            case .large: return 8
            }
        }
    }
}

#Preview {
    VStack(spacing: 30) {
        // Product card example
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.1))
                    .frame(height: 200)

                DiscountBadge(discount: 30)
                    .padding(12)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Wireless Headphones")
                    .font(.headline)

                HStack {
                    Text("$69.99")
                        .font(.title3)
                        .fontWeight(.bold)

                    Text("$99.99")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .strikethrough()
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 4)

        // Badge variations
        VStack(alignment: .leading, spacing: 16) {
            Text("Badge Variations")
                .font(.headline)

            HStack(spacing: 12) {
                DiscountBadge(discount: 50, style: .percentage, size: .small)
                DiscountBadge(discount: 25, style: .percentage, size: .medium)
                DiscountBadge(discount: 15, style: .percentage, size: .large)
            }

            HStack(spacing: 12) {
                DiscountBadge(text: "SALE", style: .sale, size: .small)
                DiscountBadge(text: "NEW", style: .new, size: .medium)
                DiscountBadge(text: "HOT", style: .custom(color: .purple), size: .large)
            }
        }
    }
    .padding()
}
