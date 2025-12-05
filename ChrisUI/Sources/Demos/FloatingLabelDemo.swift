//
//  FloatingLabelDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

struct FloatingLabelDemo: View {
    @State private var viewModel = FloatingLabelViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                FloatingLabelTextField(
                    placeholder: "Email",
                    text: $viewModel.email,
                    keyboardType: .emailAddress,
                    autocapitalization: .never,
                    validation: viewModel.emailValidation
                )

                FloatingLabelTextField(
                    placeholder: "Password",
                    text: $viewModel.password,
                    isSecure: true
                )

                FloatingLabelTextField(
                    placeholder: "Full Name",
                    text: $viewModel.name,
                    validation: viewModel.nameValidation
                )

                Button("Submit") {
                    viewModel.submit()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .foregroundStyle(.white)
                .cornerRadius(12)
            }
            .padding()
        }
        .navigationTitle("Floating Labels")
        .navigationBarTitleDisplayMode(.inline)
    }
}
