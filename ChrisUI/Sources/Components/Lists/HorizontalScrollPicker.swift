//
//  HorizontalScrollPicker.swift
//  ChrisUI
//
//  A Netflix-style horizontal carousel component
//

import SwiftUI

/// A horizontal scrolling carousel for displaying items
///
/// This component creates a horizontal scrolling view similar to Netflix-style
/// carousels, perfect for displaying media, products, or card collections.
///
/// Example:
/// ```swift
/// HorizontalScrollPicker(
///     title: "Featured Items",
///     items: products,
///     itemWidth: 200
/// ) { product in
///     ProductCard(product: product)
/// }
/// ```
public struct HorizontalScrollPicker<Item: Identifiable, Content: View>: View {
    private let title: String?
    private let items: [Item]
    private let itemWidth: CGFloat
    private let spacing: CGFloat
    private let showsIndicators: Bool
    private let content: (Item) -> Content

    /// Creates a horizontal scroll picker
    /// - Parameters:
    ///   - title: Optional section title
    ///   - items: Array of identifiable items
    ///   - itemWidth: Width of each item
    ///   - spacing: Spacing between items
    ///   - showsIndicators: Whether to show scroll indicators
    ///   - content: ViewBuilder for each item
    public init(
        title: String? = nil,
        items: [Item],
        itemWidth: CGFloat = 200,
        spacing: CGFloat = 16,
        showsIndicators: Bool = false,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.title = title
        self.items = items
        self.itemWidth = itemWidth
        self.spacing = spacing
        self.showsIndicators = showsIndicators
        self.content = content
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title = title {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
            }

            ScrollView(.horizontal, showsIndicators: showsIndicators) {
                LazyHStack(spacing: spacing) {
                    ForEach(items) { item in
                        content(item)
                            .frame(width: itemWidth)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    struct PreviewItem: Identifiable {
        let id = UUID()
        let title: String
        let subtitle: String
        let color: Color
    }

    let items = [
        PreviewItem(title: "Movie 1", subtitle: "Action", color: .red),
        PreviewItem(title: "Movie 2", subtitle: "Comedy", color: .blue),
        PreviewItem(title: "Movie 3", subtitle: "Drama", color: .green),
        PreviewItem(title: "Movie 4", subtitle: "Thriller", color: .orange),
        PreviewItem(title: "Movie 5", subtitle: "Romance", color: .pink)
    ]

    return ScrollView {
        VStack(spacing: 30) {
            HorizontalScrollPicker(
                title: "Trending Now",
                items: items,
                itemWidth: 250
            ) { item in
                VStack(alignment: .leading, spacing: 8) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(item.color.gradient)
                        .frame(height: 140)
                        .overlay {
                            VStack {
                                Image(systemName: "play.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundStyle(.white)
                            }
                        }

                    Text(item.title)
                        .font(.headline)

                    Text(item.subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            HorizontalScrollPicker(
                title: "Popular",
                items: items,
                itemWidth: 180
            ) { item in
                VStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(item.color.gradient)
                        .frame(height: 100)

                    Text(item.title)
                        .font(.subheadline)
                        .lineLimit(1)
                }
            }
        }
        .padding(.vertical)
    }
}
