//
//  InfiniteScrollListDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the InfiniteScrollList component with pagination
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

#Preview {
    NavigationStack {
        InfiniteScrollListDemo()
    }
}
