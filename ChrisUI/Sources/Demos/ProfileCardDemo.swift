//
//  ProfileCardDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demo view showcasing ProfileCard and ProfileCardExtended components
///
/// This demo displays both basic profile cards and extended versions with statistics,
/// demonstrating different use cases for user profile displays.
struct ProfileCardDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Basic Profile Cards")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                ProfileCard(
                    name: "John Doe",
                    subtitle: "Software Engineer",
                    onTap: { print("Profile tapped") }
                )

                ProfileCard(
                    name: "Jane Smith",
                    subtitle: "Product Designer",
                    showChevron: false,
                    onTap: { print("Profile tapped") }
                )

                Text("Extended Profile Cards")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)

                ProfileCardExtended(
                    name: "John Doe",
                    subtitle: "Software Engineer",
                    stats: [
                        .init(label: "Posts", value: "128"),
                        .init(label: "Followers", value: "1.2K"),
                        .init(label: "Following", value: "456"),
                    ],
                    onTap: { print("Profile tapped") }
                )

                ProfileCardExtended(
                    name: "Jane Smith",
                    subtitle: "Product Designer",
                    stats: [
                        .init(label: "Projects", value: "24"),
                        .init(label: "Reviews", value: "89"),
                    ],
                    onTap: { print("Profile tapped") }
                )
            }
            .padding()
        }
        .navigationTitle("Profile Cards")
        .navigationBarTitleDisplayMode(.inline)
    }
}
