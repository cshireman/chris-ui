//
//  SignUpScreen.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// A customizable sign-up screen component with comprehensive validation
///
/// This component provides a complete registration interface with full name, email,
/// password, and password confirmation fields. It includes real-time validation,
/// password strength requirements, and terms & conditions acceptance.
///
/// Example:
/// ```swift
/// struct MyView: View {
///     @State private var viewModel = SignUpViewModel()
///
///     var body: some View {
///         SignUpScreen(viewModel)
///     }
/// }
/// ```
///
/// Features:
/// - Full name input field
/// - Email validation
/// - Password strength validation (minimum 8 characters)
/// - Password confirmation matching
/// - Password visibility toggles
/// - Terms & conditions checkbox
/// - Loading state during registration
/// - Login navigation link
public struct SignUpScreen: View {
    @State var viewModel: SignUpViewModel = .init()

    /// Creates a sign-up screen with an optional view model
    /// - Parameter viewModel: Optional view model to control the screen state.
    ///   If nil, a default view model will be created.
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

    /// The header section displaying the title and subtitle
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

    /// The full name input field with word capitalization
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

    /// The email input field with email keyboard type
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

    /// The password input field with visibility toggle and length validation
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

    /// The password confirmation field with visibility toggle and match validation
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

    /// The terms and conditions acceptance checkbox
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

    /// The primary sign-up button with loading state and form validation
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

    /// The login navigation link for existing users
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
