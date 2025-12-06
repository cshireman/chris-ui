//
//  SwipeableListRowDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the SwipeableListRow component with delete and archive actions
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

#Preview {
    NavigationStack {
        SwipeableListRowDemo()
    }
}
