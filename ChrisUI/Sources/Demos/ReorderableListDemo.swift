//
//  ReorderableListDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the ReorderableList component with drag-to-reorder functionality
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
            }
        }
        .navigationTitle("Reorderable List")
    }
}

#Preview {
    NavigationStack {
        ReorderableListDemo()
    }
}
