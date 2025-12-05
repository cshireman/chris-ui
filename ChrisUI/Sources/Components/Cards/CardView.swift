//
//  CardView.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// An elevated container card with shadow and customizable styling
public struct CardView<Content: View>: View {
    let content: Content

    private var backgroundColor: Color
    private var cornerRadius: CGFloat
    private var shadowRadius: CGFloat = 4
    private var shadowColor: Color
    private var padding: CGFloat
    private var borderColor: Color?
    private var borderWidth: CGFloat

    public init(
        backgroundColor: Color = Color(.systemBackground),
        cornerRadius: CGFloat = 16,
        shadowRadius: CGFloat = 4,
        shadowColor: Color = .black.opacity(0.1),
        padding: CGFloat = 16,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0,
        @ViewBuilder content: () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.shadowColor = shadowColor
        self.padding = padding
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.content = content()
    }

    public var body: some View {
        content
            .padding(padding)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(color: shadowColor, radius: shadowRadius, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor ?? .clear, lineWidth: borderWidth)
            )
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 20) {
            CardView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Basic Card")
                        .font(.headline)

                    Text("This is a basic card with default styling.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            CardView(
                backgroundColor: .blue.opacity(0.1),
                borderColor: .blue,
                borderWidth: 1
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundStyle(.blue)
                        Text("Info Card")
                            .font(.headline)
                    }

                    Text("This is an info card with custom background and border.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            CardView(
                cornerRadius: 12,
                shadowRadius: 8,
                padding: 20
            ) {
                VStack(spacing: 16) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.yellow)

                    Text("Featured Content")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("This card has increased shadow and padding for emphasis.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
    }
}
