//
//  ReorderableList.swift
//  ChrisUI
//
//  A list with drag-to-reorder functionality
//

import SwiftUI

/// A list that supports drag-and-drop reordering of items
///
/// This component allows users to reorder items by dragging and dropping them
/// to new positions in the list.
///
/// Example:
/// ```swift
/// ReorderableList(items: $tasks) { task in
///     Text(task.title)
/// } onMove: { from, to in
///     tasks.move(fromOffsets: from, toOffset: to)
/// }
/// ```
public struct ReorderableList<Item: Identifiable, Content: View>: View {
    @Binding private var items: [Item]
    private let content: (Item) -> Content
    private let onMove: ((IndexSet, Int) -> Void)?

    /// Creates a reorderable list
    /// - Parameters:
    ///   - items: Binding to array of items
    ///   - content: ViewBuilder for each item
    ///   - onMove: Optional custom move handler
    public init(
        items: Binding<[Item]>,
        @ViewBuilder content: @escaping (Item) -> Content,
        onMove: ((IndexSet, Int) -> Void)? = nil
    ) {
        self._items = items
        self.content = content
        self.onMove = onMove
    }

    public var body: some View {
        List {
            ForEach(items) { item in
                content(item)
            }
            .onMove { from, to in
                if let onMove = onMove {
                    onMove(from, to)
                } else {
                    items.move(fromOffsets: from, toOffset: to)
                }
            }
        }
        .environment(\.editMode, .constant(.active))
    }
}

#Preview {
    struct PreviewItem: Identifiable {
        let id = UUID()
        let title: String
        var order: Int
    }

    struct PreviewWrapper: View {
        @State private var items = [
            PreviewItem(title: "First Item", order: 1),
            PreviewItem(title: "Second Item", order: 2),
            PreviewItem(title: "Third Item", order: 3),
            PreviewItem(title: "Fourth Item", order: 4),
            PreviewItem(title: "Fifth Item", order: 5)
        ]

        var body: some View {
            NavigationStack {
                ReorderableList(items: $items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                            Text("Order: \(item.order)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.secondary)
                    }
                } onMove: { from, to in
                    items.move(fromOffsets: from, toOffset: to)
                    // Update order numbers
                    for (index, _) in items.enumerated() {
                        items[index].order = index + 1
                    }
                }
                .navigationTitle("Reorderable List")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

    return PreviewWrapper()
}
