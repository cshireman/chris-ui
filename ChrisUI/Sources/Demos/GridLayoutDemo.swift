//
//  GridLayoutDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the GridLayout component with different column configurations
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

#Preview {
    GridLayoutDemo()
}
