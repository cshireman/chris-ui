//
//  ExpandableListDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the ExpandableList component with categorized items
struct ExpandableListDemo: View {
    let sections = [
        ExpandableSection(
            title: "Fruits",
            items: [
                DemoItem(title: "Apple", subtitle: "Red and crunchy"),
                DemoItem(title: "Banana", subtitle: "Yellow and soft"),
                DemoItem(title: "Orange", subtitle: "Citrus fruit")
            ]
        ),
        ExpandableSection(
            title: "Vegetables",
            items: [
                DemoItem(title: "Carrot", subtitle: "Orange vegetable"),
                DemoItem(title: "Broccoli", subtitle: "Green vegetable"),
                DemoItem(title: "Spinach", subtitle: "Leafy green")
            ]
        ),
        ExpandableSection(
            title: "Grains",
            items: [
                DemoItem(title: "Rice", subtitle: "Staple grain"),
                DemoItem(title: "Wheat", subtitle: "For bread"),
                DemoItem(title: "Oats", subtitle: "For breakfast")
            ]
        )
    ]

    var body: some View {
        ExpandableList(sections: sections, expandedByDefault: false) { item in
            HStack {
                Image(systemName: "circle.fill")
                    .font(.caption)
                    .foregroundStyle(.blue)
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.subheadline)
                    Text(item.subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Expandable List")
    }
}

#Preview {
    NavigationStack {
        ExpandableListDemo()
    }
}
