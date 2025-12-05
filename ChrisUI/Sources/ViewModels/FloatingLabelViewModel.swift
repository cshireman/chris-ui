//
//  FloatingLabelViewModel.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import Combine
import Foundation

/// View model for managing floating label text field demo state
///
/// This observable class demonstrates validation logic for the
/// FloatingLabelTextField component with real-time validation.
@Observable
class FloatingLabelViewModel {
    /// Email input value
    var email: String = ""
    /// Password input value
    var password: String = ""
    /// Name input value
    var name: String = ""

    /// Computed validation state for the email field
    var emailValidation: ValidationState {
        if email.isEmpty {
            return .idle
        }
        return email.isValidEmail ? .valid : .invalid("Invalid email format")
    }

    /// Computed validation state for the name field
    var nameValidation: ValidationState {
        if name.isEmpty {
            return .idle
        }
        return name.count >= 2 ? .valid : .invalid("Name must be at least 2 characters")
    }

    /// Handles form submission
    func submit() {
        print("Floating label form submitted: \(name), \(email)")
    }
}
