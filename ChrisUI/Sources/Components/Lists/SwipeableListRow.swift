//
//  SwipeableListRow.swift
//  ChrisUI
//
//  A list row with swipe actions for delete/edit
//

import SwiftUI

/// A list row with customizable swipe actions
///
/// This component provides a reusable row with trailing and leading swipe actions,
/// commonly used for delete, edit, and other contextual actions.
///
/// Example:
/// ```swift
/// SwipeableListRow {
///     Text("Swipe me")
/// } trailingActions: {
///     Button(role: .destructive) {
///         deleteItem()
///     } label: {
///         Label("Delete", systemImage: "trash")
///     }
/// } leadingActions: {
///     Button {
///         archiveItem()
///     } label: {
///         Label("Archive", systemImage: "archivebox")
///     }
/// }
/// ```
public struct SwipeableListRow<Content: View>: View {
    private let content: Content
    private let trailingActions: [SwipeAction]
    private let leadingActions: [SwipeAction]

    /// Creates a swipeable list row with custom actions
    /// - Parameters:
    ///   - trailingActions: Actions shown when swiping left
    ///   - leadingActions: Actions shown when swiping right
    ///   - content: The main content of the row
    public init(
        trailingActions: [SwipeAction] = [],
        leadingActions: [SwipeAction] = [],
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.trailingActions = trailingActions
        self.leadingActions = leadingActions
    }

    public var body: some View {
        content
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                ForEach(trailingActions) { action in
                    Button(role: action.role) {
                        action.action()
                    } label: {
                        Label(action.title, systemImage: action.icon)
                    }
                    .tint(action.tint)
                }
            }
            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                ForEach(leadingActions) { action in
                    Button {
                        action.action()
                    } label: {
                        Label(action.title, systemImage: action.icon)
                    }
                    .tint(action.tint)
                }
            }
    }
}

// MARK: - Swipe Action

/// Configuration for a swipe action
public struct SwipeAction: Identifiable {
    public let id = UUID()
    let title: String
    let icon: String
    let tint: Color
    let role: ButtonRole?
    let action: () -> Void

    /// Creates a swipe action
    /// - Parameters:
    ///   - title: Action title
    ///   - icon: SF Symbol name
    ///   - tint: Action color
    ///   - role: Button role (e.g., .destructive)
    ///   - action: Action to perform
    public init(
        title: String,
        icon: String,
        tint: Color = .blue,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.tint = tint
        self.role = role
        self.action = action
    }
}

#Preview {
    struct PreviewItem: Identifiable {
        let id = UUID()
        let title: String
        let subtitle: String
    }

    struct PreviewWrapper: View {
        @State private var items = [
            PreviewItem(title: "Email 1", subtitle: "Swipe for actions"),
            PreviewItem(title: "Email 2", subtitle: "Delete or archive"),
            PreviewItem(title: "Email 3", subtitle: "Try both directions")
        ]

        var body: some View {
            NavigationStack {
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
    }

    return PreviewWrapper()
}
