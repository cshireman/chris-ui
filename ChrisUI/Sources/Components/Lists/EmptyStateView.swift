//
//  EmptyStateView.swift
//  ChrisUI
//
//  A placeholder view for empty lists and collections
//

import SwiftUI

/// A view displayed when a list or collection has no content
///
/// This component provides a polished empty state with an icon, title, message,
/// and optional action button to guide users when content is unavailable.
///
/// Example:
/// ```swift
/// if items.isEmpty {
///     EmptyStateView(
///         icon: "tray",
///         title: "No Items",
///         message: "Add your first item to get started"
///     ) {
///         Button("Add Item") {
///             addItem()
///         }
///     }
/// }
/// ```
public struct EmptyStateView<Action: View>: View {
    private let icon: String
    private let title: String
    private let message: String
    private let action: Action?

    /// Creates an empty state view
    /// - Parameters:
    ///   - icon: SF Symbol name for the icon
    ///   - title: Primary title text
    ///   - message: Descriptive message text
    ///   - action: Optional action button
    public init(
        icon: String,
        title: String,
        message: String,
        @ViewBuilder action: () -> Action = { EmptyView() }
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.action = action()
    }

    public var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: icon)
                .font(.system(size: 60))
                .foregroundStyle(.secondary)

            VStack(spacing: 8) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(message)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }

            if action != nil {
                action
                    .padding(.top, 8)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title). \(message)")
    }
}

#Preview {
    TabView {
        EmptyStateView(
            icon: "tray",
            title: "No Messages",
            message: "Your inbox is empty"
        ) {
            Button("Compose") {
                print("Compose tapped")
            }
            .buttonStyle(.borderedProminent)
        }
        .tabItem {
            Label("With Action", systemImage: "1.circle")
        }

        EmptyStateView(
            icon: "magnifyingglass",
            title: "No Results",
            message: "We couldn't find any matches for your search"
        )
        .tabItem {
            Label("No Action", systemImage: "2.circle")
        }

        EmptyStateView(
            icon: "wifi.slash",
            title: "No Connection",
            message: "Please check your internet connection and try again"
        ) {
            Button("Retry") {
                print("Retry tapped")
            }
            .buttonStyle(.bordered)
        }
        .tabItem {
            Label("Error State", systemImage: "3.circle")
        }
    }
}
