//
//  DemoItem.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import Foundation

/// A simple data model used across demo views
struct DemoItem: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String

    static var sampleItems: [DemoItem] {
        [
            DemoItem(title: "First Item", subtitle: "Description 1"),
            DemoItem(title: "Second Item", subtitle: "Description 2"),
            DemoItem(title: "Third Item", subtitle: "Description 3"),
            DemoItem(title: "Fourth Item", subtitle: "Description 4"),
            DemoItem(title: "Fifth Item", subtitle: "Description 5"),
            DemoItem(title: "Sixth Item", subtitle: "Description 6"),
            DemoItem(title: "Seventh Item", subtitle: "Description 7"),
            DemoItem(title: "Eighth Item", subtitle: "Description 8")
        ]
    }

    static func random() -> DemoItem {
        DemoItem(
            title: "Item \(Int.random(in: 1...100))",
            subtitle: "Random description"
        )
    }
}
