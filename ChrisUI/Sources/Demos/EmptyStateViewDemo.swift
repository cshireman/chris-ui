//
//  EmptyStateViewDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the EmptyStateView component with add/remove functionality
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

#Preview {
    NavigationStack {
        EmptyStateViewDemo()
    }
}
