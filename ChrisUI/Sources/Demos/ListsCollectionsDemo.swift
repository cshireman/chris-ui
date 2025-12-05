//
//  ListsCollectionsDemo.swift
//  ChrisUI
//
//  Demonstrations for all Lists & Collections components
//

import SwiftUI

// MARK: - Pull to Refresh List Demo

struct PullToRefreshListDemo: View {
    @State private var items: [DemoItem] = DemoItem.sampleItems

    var body: some View {
        PullToRefreshList(items: items) { item in
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)
        } onRefresh: {
            try? await Task.sleep(for: .seconds(1))
            items.shuffle()
        }
        .navigationTitle("Pull to Refresh")
    }
}

// MARK: - Infinite Scroll List Demo

struct InfiniteScrollListDemo: View {
    @State private var items: [DemoItem] = Array(DemoItem.sampleItems.prefix(10))
    @State private var isLoading = false
    @State private var currentPage = 1

    var body: some View {
        InfiniteScrollList(
            items: items,
            isLoading: isLoading,
            hasMore: currentPage < 5
        ) { item in
            HStack {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Text("#\(item.id.uuidString.prefix(4))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        } onLoadMore: {
            isLoading = true
            try? await Task.sleep(for: .seconds(1))

            let newItems = (0..<10).map { _ in
                DemoItem.random()
            }
            items.append(contentsOf: newItems)
            currentPage += 1
            isLoading = false
        }
        .navigationTitle("Infinite Scroll")
    }
}

// MARK: - Swipeable List Row Demo

struct SwipeableListRowDemo: View {
    @State private var items = DemoItem.sampleItems

    var body: some View {
        List(items) { item in
            SwipeableListRow(
                trailingActions: [
                    SwipeAction(
                        title: "Delete",
                        icon: "trash",
                        tint: .red,
                        role: .destructive
                    ) {
                        if let index = items.firstIndex(where: { $0.id == item.id }) {
                            items.remove(at: index)
                        }
                    }
                ],
                leadingActions: [
                    SwipeAction(
                        title: "Archive",
                        icon: "archivebox",
                        tint: .blue
                    ) {
                        print("Archive \(item.title)")
                    },
                    SwipeAction(
                        title: "Pin",
                        icon: "pin.fill",
                        tint: .orange
                    ) {
                        print("Pin \(item.title)")
                    }
                ]
            ) {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Swipeable Rows")
    }
}

// MARK: - Expandable List Demo

struct ExpandableListDemo: View {
    let sections = [
        ExpandableSection(
            title: "Fruits",
            items: [
                DemoItem(title: "Apple", subtitle: "Red and crunchy"),
                DemoItem(title: "Banana", subtitle: "Yellow and soft"),
                DemoItem(title: "Orange", subtitle: "Citrus fruit")
            ]
        ),
        ExpandableSection(
            title: "Vegetables",
            items: [
                DemoItem(title: "Carrot", subtitle: "Orange vegetable"),
                DemoItem(title: "Broccoli", subtitle: "Green vegetable"),
                DemoItem(title: "Spinach", subtitle: "Leafy green")
            ]
        ),
        ExpandableSection(
            title: "Grains",
            items: [
                DemoItem(title: "Rice", subtitle: "Staple grain"),
                DemoItem(title: "Wheat", subtitle: "For bread"),
                DemoItem(title: "Oats", subtitle: "For breakfast")
            ]
        )
    ]

    var body: some View {
        ExpandableList(sections: sections, expandedByDefault: false) { item in
            HStack {
                Image(systemName: "circle.fill")
                    .font(.caption)
                    .foregroundStyle(.blue)
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.subheadline)
                    Text(item.subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Expandable List")
    }
}

// MARK: - Grid Layout Demo

struct GridLayoutDemo: View {
    let items = (0..<20).map { i in
        DemoItem(
            title: "Item \(i + 1)",
            subtitle: "Description \(i + 1)"
        )
    }

    var body: some View {
        TabView {
            GridLayout(items: items, columns: .fixed(2)) { item in
                cardView(for: item, color: .blue)
            }
            .tabItem {
                Label("Fixed 2", systemImage: "square.grid.2x2")
            }

            GridLayout(items: items, columns: .adaptive(minimum: 100)) { item in
                cardView(for: item, color: .green)
            }
            .tabItem {
                Label("Adaptive", systemImage: "square.grid.3x3")
            }

            GridLayout(items: items, columns: .flexible(3)) { item in
                cardView(for: item, color: .purple)
            }
            .tabItem {
                Label("Flexible 3", systemImage: "square.grid.4x3.fill")
            }
        }
        .navigationTitle("Grid Layout")
    }

    private func cardView(for item: DemoItem, color: Color) -> some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(color.opacity(0.2))
                .frame(height: 100)
                .overlay {
                    Text(item.title)
                        .font(.headline)
                }
        }
    }
}

// MARK: - Horizontal Scroll Picker Demo

struct HorizontalScrollPickerDemo: View {
    let items = (0..<10).map { i in
        DemoItem(
            title: "Movie \(i + 1)",
            subtitle: "Genre"
        )
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                HorizontalScrollPicker(
                    title: "Trending Now",
                    items: items,
                    itemWidth: 250
                ) { item in
                    movieCard(for: item, color: .red)
                }

                HorizontalScrollPicker(
                    title: "Popular",
                    items: items,
                    itemWidth: 200
                ) { item in
                    movieCard(for: item, color: .blue)
                }

                HorizontalScrollPicker(
                    title: "New Releases",
                    items: items,
                    itemWidth: 180
                ) { item in
                    movieCard(for: item, color: .green)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Horizontal Scroll")
    }

    private func movieCard(for item: DemoItem, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(color.gradient)
                .frame(height: 140)
                .overlay {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.white)
                }

            Text(item.title)
                .font(.headline)

            Text(item.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Reorderable List Demo

struct ReorderableListDemo: View {
    @State private var items = (1...8).map { i in
        DemoItem(title: "Item \(i)", subtitle: "Order: \(i)")
    }

    var body: some View {
        ReorderableList(items: $items) { item in
            HStack {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "line.3.horizontal")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Reorderable List")
    }
}

// MARK: - Empty State View Demo

struct EmptyStateViewDemo: View {
    @State private var showEmpty = true
    @State private var items: [DemoItem] = []

    var body: some View {
        VStack {
            if items.isEmpty {
                EmptyStateView(
                    icon: "tray",
                    title: "No Items",
                    message: "Add your first item to get started"
                ) {
                    Button("Add Item") {
                        items.append(DemoItem.random())
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                List {
                    ForEach(items) { item in
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                            Text(item.subtitle)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .onDelete { indexSet in
                        items.remove(atOffsets: indexSet)
                    }
                }
            }
        }
        .navigationTitle("Empty State")
        .toolbar {
            if !items.isEmpty {
                Button("Clear") {
                    items.removeAll()
                }
            }
        }
    }
}

// MARK: - Demo Item Model

struct DemoItem: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String

    static var sampleItems: [DemoItem] {
        [
            DemoItem(title: "First Item", subtitle: "Description 1"),
            DemoItem(title: "Second Item", subtitle: "Description 2"),
            DemoItem(title: "Third Item", subtitle: "Description 3"),
            DemoItem(title: "Fourth Item", subtitle: "Description 4"),
            DemoItem(title: "Fifth Item", subtitle: "Description 5"),
            DemoItem(title: "Sixth Item", subtitle: "Description 6"),
            DemoItem(title: "Seventh Item", subtitle: "Description 7"),
            DemoItem(title: "Eighth Item", subtitle: "Description 8")
        ]
    }

    static func random() -> DemoItem {
        DemoItem(
            title: "Item \(Int.random(in: 1...100))",
            subtitle: "Random description"
        )
    }
}

#Preview("Pull to Refresh") {
    NavigationStack {
        PullToRefreshListDemo()
    }
}

#Preview("Infinite Scroll") {
    NavigationStack {
        InfiniteScrollListDemo()
    }
}

#Preview("Swipeable Rows") {
    NavigationStack {
        SwipeableListRowDemo()
    }
}

#Preview("Expandable List") {
    NavigationStack {
        ExpandableListDemo()
    }
}

#Preview("Grid Layout") {
    GridLayoutDemo()
}

#Preview("Horizontal Scroll") {
    NavigationStack {
        HorizontalScrollPickerDemo()
    }
}

#Preview("Reorderable List") {
    NavigationStack {
        ReorderableListDemo()
    }
}

#Preview("Empty State") {
    NavigationStack {
        EmptyStateViewDemo()
    }
}
