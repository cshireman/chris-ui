//
//  TextFieldViewModel.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import Combine
import Foundation

/// View model for managing custom text field demo state
///
/// This observable class demonstrates validation logic for the
/// CustomTextField component with real-time validation for multiple fields.
@Observable
class TextFieldViewModel {
    /// Email input value
    var email: String = ""
    /// Password input value
    var password: String = ""
    /// Username input value
    var username: String = ""

    /// Computed validation state for the email field
    var emailValidation: ValidationState {
        if email.isEmpty {
            return .idle
        }
        return email.isValidEmail ? .valid : .invalid("Invalid email address")
    }

    /// Computed validation state for the password field
    var passwordValidation: ValidationState {
        if password.isEmpty {
            return .idle
        }
        return password.count >= 8 ? .valid : .invalid("Password must be at least 8 characters")
    }

    /// Computed validation state for the username field
    var usernameValidation: ValidationState {
        if username.isEmpty {
            return .idle
        }
        return username.count >= 3 ? .valid : .invalid("Username must be at least 3 characters")
    }

    /// Handles form submission after validation
    func submit() {
        guard emailValidation.isValid, passwordValidation.isValid, usernameValidation.isValid else {
            print("Form validation failed")
            return
        }

        print("Form submitted: \(username), \(email)")
    }
}
