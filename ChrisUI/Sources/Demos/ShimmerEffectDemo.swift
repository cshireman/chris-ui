//
//  ShimmerEffectDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

struct ShimmerEffectDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Loading Placeholder")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

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
        .navigationTitle("Shimmer Effect")
        .navigationBarTitleDisplayMode(.inline)
    }
}
