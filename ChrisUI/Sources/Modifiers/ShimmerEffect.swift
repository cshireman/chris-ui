//
//  ShimmerEffect.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// A shimmer/loading effect modifier
public struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0

    var duration: Double = 1.5
    var bounce: Bool = false

    public func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    .clear,
                                    .white.opacity(0.6),
                                    .clear
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .rotationEffect(.degrees(30))
                        .offset(x: phase * geometry.size.width * 2 - geometry.size.width)
                }
            )
            .clipped()
            .onAppear {
                withAnimation(
                    .linear(duration: duration)
                    .repeatForever(autoreverses: bounce)
                ) {
                    phase = 1
                }
            }
    }
}

extension View {
    /// Applies a shimmer effect to the view
    public func shimmer(duration: Double = 1.5, bounce: Bool = false) -> some View {
        modifier(ShimmerModifier(duration: duration, bounce: bounce))
    }
}

#Preview {
    VStack(spacing: 20) {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color(.systemGray5))
            .frame(height: 100)
            .shimmer()

        VStack(alignment: .leading, spacing: 12) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray5))
                .frame(height: 20)

            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray5))
                .frame(width: 200, height: 20)

            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray5))
                .frame(width: 150, height: 20)
        }
        .shimmer(duration: 2.0)

        Circle()
            .fill(Color(.systemGray5))
            .frame(width: 80, height: 80)
            .shimmer()
    }
    .padding()
}
