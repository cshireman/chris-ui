//
//  LoginViewModel.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import Foundation
import Combine

@Observable
public class LoginViewModel {
    var title: String = "Welcome Back"
    var subtitle: String = "Sign in to continue"

    var email: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var isPasswordVisible: Bool = false
    var errorMessage: String?

    func login() async {
        isLoading = true
        errorMessage = nil

        // Simulate API call
        try? await Task.sleep(nanoseconds: 1_000_000_000)

        // Validate credentials
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please fill in all fields"
        } else {
            print("Login successful: \(email)")
        }

        isLoading = false
    }

    func forgotPassword() {
        print("Forgot password tapped")
    }

    func signUp() {
        print("Navigate to sign up")
    }
}
