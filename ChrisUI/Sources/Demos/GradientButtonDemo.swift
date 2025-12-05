//
//  GradientButtonDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demo view showcasing the GradientButton component
///
/// This demo displays various configurations of gradient buttons including
/// different color schemes, gradient directions, icons, and disabled states.
struct GradientButtonDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                GradientButton(
                    title: "Default Gradient",
                    action: { print("Tapped") }
                )

                GradientButton(
                    title: "Orange to Pink",
                    gradient: Gradient(colors: [.orange, .pink]),
                    icon: "star.fill",
                    action: { print("Tapped") }
                )

                GradientButton(
                    title: "Green to Blue",
                    gradient: Gradient(colors: [.green, .blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing,
                    action: { print("Tapped") }
                )

                GradientButton(
                    title: "Disabled",
                    isDisabled: true,
                    action: { print("Tapped") }
                )
            }
            .padding()
        }
        .navigationTitle("Gradient Buttons")
        .navigationBarTitleDisplayMode(.inline)
    }
}
