//
//  ProgressRingDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the ProgressRing component with adjustable progress
struct ProgressRingDemo: View {
    @State private var progress: Double = 0.75

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ProgressRing(
                    progress: progress,
                    label: "\(Int(progress * 100))%",
                    subtitle: "Complete",
                    color: .blue
                )
                .frame(height: 200)

                ProgressRing(
                    progress: progress,
                    label: "\(Int(progress * 20))/20",
                    subtitle: "Tasks Done",
                    lineWidth: 15,
                    color: .green
                )
                .frame(height: 180)

                VStack {
                    Text("Progress: \(Int(progress * 100))%")
                        .font(.headline)

                    Slider(value: $progress, in: 0...1)
                        .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationTitle("Progress Ring")
    }
}

#Preview {
    NavigationStack {
        ProgressRingDemo()
    }
}
