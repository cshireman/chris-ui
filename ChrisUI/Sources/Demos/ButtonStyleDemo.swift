//
//  ButtonStyleDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demo view showcasing custom button styles
///
/// This demo presents the scale, fade, and pressable button styles,
/// demonstrating different tactile feedback options for button interactions.
struct ButtonStyleDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Button("Scale Button Style") {
                    print("Tapped")
                }
                .padding()
                .background(Color.blue)
                .foregroundStyle(.white)
                .cornerRadius(12)
                .buttonStyle(.scale)

                Button("Fade Button Style") {
                    print("Tapped")
                }
                .padding()
                .background(Color.green)
                .foregroundStyle(.white)
                .cornerRadius(12)
                .buttonStyle(.fade)

                Button("Pressable Button Style") {
                    print("Tapped")
                }
                .padding()
                .background(Color.orange)
                .foregroundStyle(.white)
                .cornerRadius(12)
                .buttonStyle(.pressable)
            }
            .padding()
        }
        .navigationTitle("Button Styles")
        .navigationBarTitleDisplayMode(.inline)
    }
}
