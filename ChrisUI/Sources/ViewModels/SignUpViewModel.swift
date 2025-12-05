//
//  SignUpViewModel.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import Combine
import Foundation

@Observable
public class SignUpViewModel {
    var title: String = "Create Account"
    var subtitle: String = "Sign up to get started"

    var fullName: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var isPasswordVisible: Bool = false
    var isConfirmPasswordVisible: Bool = false
    var isLoading: Bool = false
    var agreedToTerms: Bool = false
    var errorMessage: String?

    var passwordsMatch: Bool {
        !password.isEmpty && password == confirmPassword
    }

    var isFormValid: Bool {
        !fullName.isEmpty &&
            !email.isEmpty &&
            passwordsMatch &&
            agreedToTerms &&
            password.count >= 8
    }

    var showPasswordLengthError: Bool {
        !password.isEmpty && password.count < 8
    }

    var showPasswordMismatchError: Bool {
        !confirmPassword.isEmpty && !passwordsMatch
    }

    func signUp() async {
        isLoading = true
        errorMessage = nil

        // Simulate API call
        try? await Task.sleep(nanoseconds: 1_500_000_000)

        // Validate input
        if !isFormValid {
            errorMessage = "Please fill in all fields correctly"
        } else {
            print("Sign up successful: \(fullName), \(email)")
        }

        isLoading = false
    }

    func login() {
        print("Navigate to login")
    }

    func viewTerms() {
        print("View terms and conditions")
    }
}
