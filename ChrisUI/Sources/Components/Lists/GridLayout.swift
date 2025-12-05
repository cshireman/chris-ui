//
//  GridLayout.swift
//  ChrisUI
//
//  A responsive grid layout with custom sizing
//

import SwiftUI

/// A responsive grid layout that adapts to different screen sizes
///
/// This component provides a flexible grid layout with customizable column counts,
/// spacing, and adaptive sizing for different device sizes.
///
/// Example:
/// ```swift
/// GridLayout(
///     items: photos,
///     columns: .adaptive(minimum: 100),
///     spacing: 10
/// ) { photo in
///     Image(photo.name)
///         .resizable()
///         .aspectRatio(contentMode: .fill)
/// }
/// ```
public struct GridLayout<Item: Identifiable, Content: View>: View {
    private let items: [Item]
    private let columns: [GridItem]
    private let spacing: CGFloat
    private let content: (Item) -> Content

    /// Creates a grid layout
    /// - Parameters:
    ///   - items: Array of identifiable items to display
    ///   - columns: Grid column configuration
    ///   - spacing: Spacing between items
    ///   - content: ViewBuilder for each item
    public init(
        items: [Item],
        columns: GridColumns = .fixed(2),
        spacing: CGFloat = 16,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self.spacing = spacing
        self.content = content

        switch columns {
        case .fixed(let count):
            self.columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: count)
        case .adaptive(let minimum):
            self.columns = [GridItem(.adaptive(minimum: minimum), spacing: spacing)]
        case .flexible(let count):
            self.columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: count)
        }
    }

    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(items) { item in
                    content(item)
                }
            }
            .padding(spacing)
        }
    }
}

// MARK: - Grid Columns Configuration

/// Configuration options for grid columns
public enum GridColumns {
    /// Fixed number of columns
    case fixed(Int)
    /// Adaptive columns with minimum width
    case adaptive(minimum: CGFloat)
    /// Flexible columns that distribute space evenly
    case flexible(Int)
}

#Preview {
    struct PreviewItem: Identifiable {
        let id = UUID()
        let title: String
        let color: Color
    }

    let items = [
        PreviewItem(title: "1", color: .red),
        PreviewItem(title: "2", color: .blue),
        PreviewItem(title: "3", color: .green),
        PreviewItem(title: "4", color: .orange),
        PreviewItem(title: "5", color: .purple),
        PreviewItem(title: "6", color: .pink),
        PreviewItem(title: "7", color: .yellow),
        PreviewItem(title: "8", color: .cyan)
    ]

    return TabView {
        GridLayout(items: items, columns: .fixed(2)) { item in
            RoundedRectangle(cornerRadius: 12)
                .fill(item.color.gradient)
                .frame(height: 120)
                .overlay {
                    Text(item.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
        }
        .tabItem {
            Label("Fixed", systemImage: "square.grid.2x2")
        }

        GridLayout(items: items, columns: .adaptive(minimum: 100)) { item in
            RoundedRectangle(cornerRadius: 12)
                .fill(item.color.gradient)
                .frame(height: 100)
                .overlay {
                    Text(item.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
        }
        .tabItem {
            Label("Adaptive", systemImage: "square.grid.3x3")
        }

        GridLayout(items: items, columns: .flexible(3)) { item in
            RoundedRectangle(cornerRadius: 12)
                .fill(item.color.gradient)
                .frame(height: 80)
                .overlay {
                    Text(item.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
        }
        .tabItem {
            Label("Flexible", systemImage: "square.grid.4x3.fill")
        }
    }
}
