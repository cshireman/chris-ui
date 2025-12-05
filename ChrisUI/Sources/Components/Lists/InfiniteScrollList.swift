//
//  InfiniteScrollList.swift
//  ChrisUI
//
//  A list with infinite scroll/lazy loading pagination
//

import SwiftUI

/// A list view that automatically loads more content as the user scrolls
///
/// This component implements infinite scrolling by detecting when the user
/// reaches the bottom of the list and triggering a load more action.
///
/// Example:
/// ```swift
/// InfiniteScrollList(
///     items: viewModel.items,
///     isLoading: viewModel.isLoading,
///     hasMore: viewModel.hasMorePages
/// ) { item in
///     Text(item.title)
/// } onLoadMore: {
///     await viewModel.loadNextPage()
/// }
/// ```
public struct InfiniteScrollList<Item: Identifiable, RowContent: View>: View {
    private let items: [Item]
    private let isLoading: Bool
    private let hasMore: Bool
    private let rowContent: (Item) -> RowContent
    private let onLoadMore: () async -> Void
    private let threshold: Int

    /// Creates an infinite scroll list
    /// - Parameters:
    ///   - items: Array of identifiable items to display
    ///   - isLoading: Whether data is currently being loaded
    ///   - hasMore: Whether more items are available to load
    ///   - threshold: Number of items from bottom to trigger load (default: 3)
    ///   - rowContent: ViewBuilder for each row
    ///   - onLoadMore: Async action to load more items
    public init(
        items: [Item],
        isLoading: Bool,
        hasMore: Bool,
        threshold: Int = 3,
        @ViewBuilder rowContent: @escaping (Item) -> RowContent,
        onLoadMore: @escaping () async -> Void
    ) {
        self.items = items
        self.isLoading = isLoading
        self.hasMore = hasMore
        self.threshold = threshold
        self.rowContent = rowContent
        self.onLoadMore = onLoadMore
    }

    public var body: some View {
        List {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                rowContent(item)
                    .task {
                        if shouldLoadMore(at: index) {
                            await onLoadMore()
                        }
                    }
            }

            if isLoading {
                loadingView
            }
        }
        .accessibilityLabel("Infinite scroll list")
    }

    // MARK: - Subviews

    private var loadingView: some View {
        HStack {
            Spacer()
            ProgressView()
                .accessibilityLabel("Loading more items")
            Spacer()
        }
        .padding()
    }

    // MARK: - Helper Methods

    private func shouldLoadMore(at index: Int) -> Bool {
        guard hasMore && !isLoading else { return false }
        return index >= items.count - threshold
    }
}

#Preview {
    struct PreviewItem: Identifiable {
        let id = UUID()
        let title: String
        let number: Int
    }

    struct PreviewWrapper: View {
        @State private var items: [PreviewItem] = (1...20).map {
            PreviewItem(title: "Item \($0)", number: $0)
        }
        @State private var isLoading = false
        @State private var currentPage = 1

        var body: some View {
            NavigationStack {
                InfiniteScrollList(
                    items: items,
                    isLoading: isLoading,
                    hasMore: currentPage < 5
                ) { item in
                    HStack {
                        Text(item.title)
                        Spacer()
                        Text("#\(item.number)")
                            .foregroundStyle(.secondary)
                    }
                } onLoadMore: {
                    isLoading = true
                    try? await Task.sleep(for: .seconds(1))

                    currentPage += 1
                    let newItems = (1...10).map { i in
                        let number = items.count + i
                        return PreviewItem(title: "Item \(number)", number: number)
                    }
                    items.append(contentsOf: newItems)
                    isLoading = false
                }
                .navigationTitle("Infinite Scroll")
            }
        }
    }

    return PreviewWrapper()
}
