//
//  IconButtonDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

struct IconButtonDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack(spacing: 16) {
                    Text("Basic Icons")
                        .font(.headline)

                    HStack(spacing: 16) {
                        IconButton(icon: "heart", action: { print("Heart") })
                        IconButton(icon: "bookmark", action: { print("Bookmark") })
                        IconButton(icon: "star", action: { print("Star") })
                        IconButton(icon: "bell", action: { print("Bell") })
                    }
                }

                VStack(spacing: 16) {
                    Text("Colored Icons")
                        .font(.headline)

                    HStack(spacing: 16) {
                        IconButton(
                            icon: "heart.fill",
                            backgroundColor: .red,
                            foregroundColor: .white,
                            action: { print("Heart") }
                        )
                        IconButton(
                            icon: "bookmark.fill",
                            backgroundColor: .blue,
                            foregroundColor: .white,
                            action: { print("Bookmark") }
                        )
                        IconButton(
                            icon: "star.fill",
                            backgroundColor: .yellow,
                            foregroundColor: .white,
                            action: { print("Star") }
                        )
                    }
                }

                VStack(spacing: 16) {
                    Text("Different Sizes")
                        .font(.headline)

                    HStack(alignment: .center, spacing: 16) {
                        IconButton(
                            icon: "plus",
                            size: 32,
                            backgroundColor: .accentColor,
                            foregroundColor: .white,
                            action: { print("Small") }
                        )
                        IconButton(
                            icon: "plus",
                            size: 44,
                            backgroundColor: .accentColor,
                            foregroundColor: .white,
                            action: { print("Medium") }
                        )
                        IconButton(
                            icon: "plus",
                            size: 56,
                            backgroundColor: .accentColor,
                            foregroundColor: .white,
                            action: { print("Large") }
                        )
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Icon Buttons")
        .navigationBarTitleDisplayMode(.inline)
    }
}
