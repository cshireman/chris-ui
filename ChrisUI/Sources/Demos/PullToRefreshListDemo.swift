//
//  PullToRefreshListDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the PullToRefreshList component with shuffling items
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

#Preview {
    NavigationStack {
        PullToRefreshListDemo()
    }
}
