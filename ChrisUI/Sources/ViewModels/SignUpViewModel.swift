//
//  SignUpViewModel.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import Combine
import Foundation

/// View model for managing sign-up screen state and registration logic
///
/// This observable class manages all state for the SignUpScreen component,
/// including form inputs, validation, loading states, and registration flow.
@Observable
public class SignUpViewModel {
    /// The title displayed at the top of the sign-up screen
    var title: String = "Create Account"
    /// The subtitle displayed below the title
    var subtitle: String = "Sign up to get started"

    /// User's full name input
    var fullName: String = ""
    /// User's email input
    var email: String = ""
    /// User's password input
    var password: String = ""
    /// Password confirmation input
    var confirmPassword: String = ""
    /// Controls password field visibility
    var isPasswordVisible: Bool = false
    /// Controls confirm password field visibility
    var isConfirmPasswordVisible: Bool = false
    /// Indicates whether a registration request is in progress
    var isLoading: Bool = false
    /// Whether the user has agreed to terms and conditions
    var agreedToTerms: Bool = false
    /// Optional error message to display to the user
    var errorMessage: String?

    /// Computed property indicating if password and confirmation match
    var passwordsMatch: Bool {
        !password.isEmpty && password == confirmPassword
    }

    /// Computed property indicating if all form fields are valid
    var isFormValid: Bool {
        !fullName.isEmpty &&
            !email.isEmpty &&
            passwordsMatch &&
            agreedToTerms &&
            password.count >= 8
    }

    /// Computed property indicating if password length error should be shown
    var showPasswordLengthError: Bool {
        !password.isEmpty && password.count < 8
    }

    /// Computed property indicating if password mismatch error should be shown
    var showPasswordMismatchError: Bool {
        !confirmPassword.isEmpty && !passwordsMatch
    }

    /// Performs user registration
    ///
    /// This async method simulates an API call for user registration. In a real app,
    /// this would call your registration service and handle the response.
    func signUp() async {
        isLoading = true
        errorMessage = nil

        // Simulate API call
        try? await Task.sleep(for: .seconds(1.5))

        // Validate input
        if !isFormValid {
            errorMessage = "Please fill in all fields correctly"
        } else {
            print("Sign up successful: \(fullName), \(email)")
        }

        isLoading = false
    }

    /// Handles navigation to login screen
    ///
    /// In a real app, this would trigger navigation to the login flow.
    func login() {
        print("Navigate to login")
    }

    /// Handles viewing terms and conditions
    ///
    /// In a real app, this would display a modal or navigate to the terms page.
    func viewTerms() {
        print("View terms and conditions")
    }
}
