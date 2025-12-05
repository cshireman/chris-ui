//
//  PullToRefreshList.swift
//  ChrisUI
//
//  A customizable list with pull-to-refresh functionality
//

import SwiftUI

/// A list view with built-in pull-to-refresh capability
///
/// This component wraps a standard List with native pull-to-refresh functionality,
/// allowing users to reload content by pulling down on the list.
///
/// Example:
/// ```swift
/// PullToRefreshList(items: viewModel.items) { item in
///     Text(item.title)
/// } onRefresh: {
///     await viewModel.loadData()
/// }
/// ```
public struct PullToRefreshList<Item: Identifiable, RowContent: View>: View {
    private let items: [Item]
    private let rowContent: (Item) -> RowContent
    private let onRefresh: () async -> Void

    /// Creates a pull-to-refresh list
    /// - Parameters:
    ///   - items: Array of identifiable items to display
    ///   - rowContent: ViewBuilder for each row
    ///   - onRefresh: Async action to perform when refreshing
    public init(
        items: [Item],
        @ViewBuilder rowContent: @escaping (Item) -> RowContent,
        onRefresh: @escaping () async -> Void
    ) {
        self.items = items
        self.rowContent = rowContent
        self.onRefresh = onRefresh
    }

    public var body: some View {
        List(items) { item in
            rowContent(item)
        }
        .refreshable {
            await onRefresh()
        }
        .accessibilityLabel("Pull to refresh list")
    }
}

#Preview {
    struct PreviewItem: Identifiable {
        let id = UUID()
        let title: String
        let subtitle: String
    }

    struct PreviewWrapper: View {
        @State private var items: [PreviewItem] = [
            PreviewItem(title: "Item 1", subtitle: "Description 1"),
            PreviewItem(title: "Item 2", subtitle: "Description 2"),
            PreviewItem(title: "Item 3", subtitle: "Description 3")
        ]

        var body: some View {
            NavigationStack {
                PullToRefreshList(items: items) { item in
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                } onRefresh: {
                    try? await Task.sleep(for: .seconds(1))
                    items.shuffle()
                }
                .navigationTitle("Pull to Refresh")
            }
        }
    }

    return PreviewWrapper()
}
