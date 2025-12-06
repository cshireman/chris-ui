//
//  HorizontalScrollPickerDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the HorizontalScrollPicker component with Netflix-style carousels
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

#Preview {
    NavigationStack {
        HorizontalScrollPickerDemo()
    }
}
