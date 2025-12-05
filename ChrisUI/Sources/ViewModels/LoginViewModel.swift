//
//  LoginViewModel.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import Combine
import Foundation

/// View model for managing login screen state and authentication logic
///
/// This observable class manages all state for the LoginScreen component,
/// including form inputs, loading states, and authentication flow.
@Observable
public class LoginViewModel {
    /// The title displayed at the top of the login screen
    var title: String = "Welcome Back"
    /// The subtitle displayed below the title
    var subtitle: String = "Sign in to continue"

    /// User's email input
    var email: String = ""
    /// User's password input
    var password: String = ""
    /// Indicates whether an authentication request is in progress
    var isLoading: Bool = false
    /// Controls password field visibility (plain text vs secure)
    var isPasswordVisible: Bool = false
    /// Optional error message to display to the user
    var errorMessage: String?

    /// Performs login authentication
    ///
    /// This async method simulates an API call for authentication. In a real app,
    /// this would call your authentication service and handle the response.
    func login() async {
        isLoading = true
        errorMessage = nil

        // Simulate API call
        try? await Task.sleep(for: .seconds(1))

        // Validate credentials
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please fill in all fields"
        } else {
            print("Login successful: \(email)")
        }

        isLoading = false
    }

    /// Handles forgot password action
    ///
    /// In a real app, this would navigate to a password reset flow or
    /// display a password reset modal.
    func forgotPassword() {
        print("Forgot password tapped")
    }

    /// Handles navigation to sign up screen
    ///
    /// In a real app, this would trigger navigation to the sign up flow.
    func signUp() {
        print("Navigate to sign up")
    }
}
