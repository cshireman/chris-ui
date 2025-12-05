//
//  ExpandableList.swift
//  ChrisUI
//
//  An accordion-style expandable list component
//

import SwiftUI

/// An accordion-style list with expandable/collapsible sections
///
/// This component displays a list of sections that can be individually expanded
/// or collapsed, similar to an accordion UI pattern.
///
/// Example:
/// ```swift
/// ExpandableList(sections: [
///     ExpandableSection(title: "Section 1", items: ["Item 1", "Item 2"]),
///     ExpandableSection(title: "Section 2", items: ["Item 3", "Item 4"])
/// ]) { item in
///     Text(item)
/// }
/// ```
public struct ExpandableList<Item: Identifiable, ItemView: View>: View {
    private let sections: [ExpandableSection<Item>]
    private let itemContent: (Item) -> ItemView
    @State private var expandedSections: Set<UUID> = []

    /// Creates an expandable list
    /// - Parameters:
    ///   - sections: Array of expandable sections
    ///   - expandedByDefault: Whether sections start expanded
    ///   - itemContent: ViewBuilder for each item
    public init(
        sections: [ExpandableSection<Item>],
        expandedByDefault: Bool = false,
        @ViewBuilder itemContent: @escaping (Item) -> ItemView
    ) {
        self.sections = sections
        self.itemContent = itemContent

        if expandedByDefault {
            _expandedSections = State(initialValue: Set(sections.map { $0.id }))
        }
    }

    public var body: some View {
        List {
            ForEach(sections) { section in
                Section {
                    if expandedSections.contains(section.id) {
                        ForEach(section.items) { item in
                            itemContent(item)
                        }
                    }
                } header: {
                    headerView(for: section)
                }
            }
        }
    }

    // MARK: - Subviews

    private func headerView(for section: ExpandableSection<Item>) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                if expandedSections.contains(section.id) {
                    expandedSections.remove(section.id)
                } else {
                    expandedSections.insert(section.id)
                }
            }
        } label: {
            HStack {
                Text(section.title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .rotationEffect(.degrees(expandedSections.contains(section.id) ? 90 : 0))
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(section.title), \(expandedSections.contains(section.id) ? "expanded" : "collapsed")")
        .accessibilityHint("Double tap to \(expandedSections.contains(section.id) ? "collapse" : "expand")")
    }
}

// MARK: - Expandable Section

/// Configuration for an expandable section
public struct ExpandableSection<Item: Identifiable>: Identifiable {
    public let id = UUID()
    public let title: String
    public let items: [Item]
    public let icon: String?

    /// Creates an expandable section
    /// - Parameters:
    ///   - title: Section title
    ///   - items: Items in the section
    ///   - icon: Optional SF Symbol name
    public init(title: String, items: [Item], icon: String? = nil) {
        self.title = title
        self.items = items
        self.icon = icon
    }
}

#Preview {
    struct PreviewItem: Identifiable {
        let id = UUID()
        let title: String
    }

    let sections = [
        ExpandableSection(
            title: "Fruits",
            items: [
                PreviewItem(title: "Apple"),
                PreviewItem(title: "Banana"),
                PreviewItem(title: "Orange")
            ]
        ),
        ExpandableSection(
            title: "Vegetables",
            items: [
                PreviewItem(title: "Carrot"),
                PreviewItem(title: "Broccoli"),
                PreviewItem(title: "Spinach")
            ]
        ),
        ExpandableSection(
            title: "Grains",
            items: [
                PreviewItem(title: "Rice"),
                PreviewItem(title: "Wheat"),
                PreviewItem(title: "Oats")
            ]
        )
    ]

    return NavigationStack {
        ExpandableList(sections: sections, expandedByDefault: true) { item in
            HStack {
                Image(systemName: "circle.fill")
                    .font(.caption)
                    .foregroundStyle(.blue)
                Text(item.title)
            }
        }
        .navigationTitle("Expandable List")
    }
}
