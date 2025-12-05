//
//  LoginScreen.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// A customizable login screen component with email/password authentication
public struct LoginScreen: View {
    @State var viewModel: LoginViewModel = .init()

    public init(_ viewModel: LoginViewModel? = nil) {
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
                    emailField
                    passwordField
                    forgotPassword
                }
                .padding(.top, 8)

                loginButton
                signUpLink

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
        }
    }

    private var forgotPassword: some View {
        HStack {
            Spacer()
            Button(action: viewModel.forgotPassword) {
                Text("Forgot Password?")
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
    }

    private var loginButton: some View {
        Button(action: {
            Task.detached {
                await viewModel.login()
            }
        }) {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundStyle(.white)
            .cornerRadius(12)
        }
        .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.isLoading)
        .opacity((viewModel.email.isEmpty || viewModel.password.isEmpty) ? 0.6 : 1.0)
    }

    private var signUpLink: some View {
        HStack(spacing: 4) {
            Text("Don't have an account?")
                .foregroundStyle(.secondary)
            Button(action: viewModel.signUp) {
                Text("Sign Up")
                    .fontWeight(.semibold)
            }
        }
        .font(.subheadline)
        .padding(.top, 8)
    }
}

#Preview {
    LoginScreen()
}
