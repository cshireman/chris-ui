//
//  ValidationState.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//
import Foundation

/// Represents the validation state of form inputs
///
/// This enum encapsulates the three possible validation states for form fields:
/// idle (not yet validated), valid (passes validation), and invalid (fails with message).
///
/// Example:
/// ```swift
/// var emailValidation: ValidationState {
///     if email.isEmpty {
///         return .idle
///     }
///     return email.isValidEmail ? .valid : .invalid("Invalid email format")
/// }
/// ```
public enum ValidationState {
    /// Field has not been validated yet or is empty
    case idle
    /// Field has passed validation
    case valid
    /// Field has failed validation with an error message
    case invalid(String)

    /// Returns true if the validation state is valid
    var isValid: Bool {
        if case .valid = self { return true }
        return false
    }

    /// Returns the error message if the state is invalid, otherwise nil
    var errorMessage: String? {
        if case let .invalid(message) = self { return message }
        return nil
    }
}
