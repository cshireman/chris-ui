//
//  CheckoutProgressDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the CheckoutProgress component with different styles
struct CheckoutProgressDemo: View {
    @State private var currentStep = 1
    let steps = ["Cart", "Shipping", "Payment", "Review"]

    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Dots Style")
                        .font(.headline)

                    CheckoutProgress(
                        steps: steps,
                        currentStep: currentStep,
                        style: .dots
                    )
                }

                VStack(alignment: .leading, spacing: 20) {
                    Text("Numbers Style")
                        .font(.headline)

                    CheckoutProgress(
                        steps: steps,
                        currentStep: currentStep,
                        style: .numbers
                    )
                }

                VStack(alignment: .leading, spacing: 20) {
                    Text("Bar Style")
                        .font(.headline)

                    CheckoutProgress(
                        steps: steps,
                        currentStep: currentStep,
                        style: .bar
                    )
                }

                HStack {
                    Button("Previous") {
                        if currentStep > 0 {
                            currentStep -= 1
                        }
                    }
                    .disabled(currentStep == 0)

                    Spacer()

                    Button("Next") {
                        if currentStep < steps.count - 1 {
                            currentStep += 1
                        }
                    }
                    .disabled(currentStep == steps.count - 1)
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .navigationTitle("Checkout Progress")
    }
}

#Preview {
    NavigationStack {
        CheckoutProgressDemo()
    }
}
