//
//  TextFieldDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

struct TextFieldDemo: View {
    @State private var viewModel = TextFieldViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CustomTextField(
                    title: "Email",
                    placeholder: "Enter your email",
                    text: $viewModel.email,
                    validation: viewModel.emailValidation,
                    keyboardType: .emailAddress,
                    autocapitalization: .never,
                    leadingIcon: "envelope"
                )

                CustomTextField(
                    title: "Password",
                    placeholder: "Enter your password",
                    text: $viewModel.password,
                    validation: viewModel.passwordValidation,
                    isSecure: true,
                    showVisibilityToggle: true,
                    leadingIcon: "lock"
                )

                CustomTextField(
                    title: "Username",
                    placeholder: "Choose a username",
                    text: $viewModel.username,
                    validation: viewModel.usernameValidation,
                    leadingIcon: "person"
                )

                Button("Submit") {
                    viewModel.submit()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .foregroundStyle(.white)
                .cornerRadius(12)
                .disabled(!viewModel.emailValidation.isValid ||
                    !viewModel.passwordValidation.isValid ||
                    !viewModel.usernameValidation.isValid)
                .opacity((viewModel.emailValidation.isValid &&
                        viewModel.passwordValidation.isValid &&
                        viewModel.usernameValidation.isValid) ? 1.0 : 0.6)
            }
            .padding()
        }
        .navigationTitle("Text Fields")
        .navigationBarTitleDisplayMode(.inline)
    }
}
