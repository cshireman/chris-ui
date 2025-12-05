//
//  TextFieldViewModel.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import Combine
import Foundation

@Observable
class TextFieldViewModel {
    var email: String = ""
    var password: String = ""
    var username: String = ""

    var emailValidation: ValidationState {
        if email.isEmpty {
            return .idle
        }
        return email.isValidEmail ? .valid : .invalid("Invalid email address")
    }

    var passwordValidation: ValidationState {
        if password.isEmpty {
            return .idle
        }
        return password.count >= 8 ? .valid : .invalid("Password must be at least 8 characters")
    }

    var usernameValidation: ValidationState {
        if username.isEmpty {
            return .idle
        }
        return username.count >= 3 ? .valid : .invalid("Username must be at least 3 characters")
    }

    func submit() {
        guard emailValidation.isValid, passwordValidation.isValid, usernameValidation.isValid else {
            print("Form validation failed")
            return
        }

        print("Form submitted: \(username), \(email)")
    }
}
