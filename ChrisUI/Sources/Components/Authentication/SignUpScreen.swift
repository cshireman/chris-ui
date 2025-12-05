//
//  SignUpScreen.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// A customizable sign-up screen component with validation
public struct SignUpScreen: View {
    @State var viewModel: SignUpViewModel = .init()

    public init(_ viewModel: SignUpViewModel? = nil) {
        if let viewModel {
            self.viewModel = viewModel
        }
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                header

                // Form Fields
                VStack(spacing: 16) {
                    fullNameField
                    emailField
                    passwordField
                    confirmPasswordField
                }
                .padding(.top, 8)

                termsCheckbox
                signUpButton
                loginLink

                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }

    private var header: some View {
        VStack(spacing: 8) {
            Text(viewModel.title)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(viewModel.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 40)
    }

    private var fullNameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Full Name")
                .font(.subheadline)
                .fontWeight(.medium)

            TextField("Enter your full name", text: $viewModel.fullName)
                .textFieldStyle(.plain)
                .textInputAutocapitalization(.words)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
        }
    }

    private var emailField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Email")
                .font(.subheadline)
                .fontWeight(.medium)

            TextField("Enter your email", text: $viewModel.email)
                .textFieldStyle(.plain)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
        }
    }

    private var passwordField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Password")
                .font(.subheadline)
                .fontWeight(.medium)

            HStack {
                if viewModel.isPasswordVisible {
                    TextField("Enter your password", text: $viewModel.password)
                        .textFieldStyle(.plain)
                } else {
                    SecureField("Enter your password", text: $viewModel.password)
                        .textFieldStyle(.plain)
                }

                Button(action: { viewModel.isPasswordVisible.toggle() }) {
                    Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)

            if viewModel.showPasswordLengthError {
                Text("Password must be at least 8 characters")
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
    }

    private var confirmPasswordField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Confirm Password")
                .font(.subheadline)
                .fontWeight(.medium)

            HStack {
                if viewModel.isConfirmPasswordVisible {
                    TextField("Confirm your password", text: $viewModel.confirmPassword)
                        .textFieldStyle(.plain)
                } else {
                    SecureField("Confirm your password", text: $viewModel.confirmPassword)
                        .textFieldStyle(.plain)
                }

                Button(action: { viewModel.isConfirmPasswordVisible.toggle() }) {
                    Image(systemName: viewModel.isConfirmPasswordVisible ? "eye.slash" : "eye")
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)

            if viewModel.showPasswordMismatchError {
                Text("Passwords do not match")
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
    }

    private var termsCheckbox: some View {
        HStack(alignment: .top, spacing: 12) {
            Button(action: { viewModel.agreedToTerms.toggle() }) {
                Image(systemName: viewModel.agreedToTerms ? "checkmark.square.fill" : "square")
                    .foregroundStyle(viewModel.agreedToTerms ? Color.accentColor : Color.secondary)
            }

            HStack(spacing: 4) {
                Text("I agree to the")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Button(action: viewModel.viewTerms) {
                    Text("Terms & Conditions")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
            }

            Spacer()
        }
    }

    private var signUpButton: some View {
        Button(action: {
            Task.detached {
                await viewModel.signUp()
            }
        }) {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Sign Up")
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundStyle(.white)
            .cornerRadius(12)
        }
        .disabled(!viewModel.isFormValid || viewModel.isLoading)
        .opacity(viewModel.isFormValid ? 1.0 : 0.6)
    }

    private var loginLink: some View {
        HStack(spacing: 4) {
            Text("Already have an account?")
                .foregroundStyle(.secondary)
            Button(action: viewModel.login) {
                Text("Sign In")
                    .fontWeight(.semibold)
            }
        }
        .font(.subheadline)
        .padding(.top, 8)
    }
}

#Preview {
    SignUpScreen()
}

