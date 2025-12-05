//
//  CardViewDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

struct CardViewDemo: View {
    var body: some View {
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

                        Text("This card has custom styling with borders.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                CardView(shadowRadius: 8, padding: 20) {
                    VStack(spacing: 16) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.yellow)

                        Text("Featured Content")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("Enhanced shadow and padding.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .navigationTitle("Card Views")
        .navigationBarTitleDisplayMode(.inline)
    }
}
