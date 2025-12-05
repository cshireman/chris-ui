//
//  Validator.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import Foundation

/// Utility class for common validation operations
public enum Validator {
    /// Validates email format
    public static func validateEmail(_ email: String) -> ValidationState {
        guard !email.isEmpty else {
            return .idle
        }

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        return emailPredicate.evaluate(with: email)
            ? .valid
            : .invalid("Please enter a valid email address")
    }

    /// Validates password strength
    public static func validatePassword(_ password: String, minLength: Int = 8) -> ValidationState {
        guard !password.isEmpty else {
            return .idle
        }

        if password.count < minLength {
            return .invalid("Password must be at least \(minLength) characters")
        }

        return .valid
    }

    /// Validates that passwords match
    public static func validatePasswordMatch(_ password: String, _ confirmPassword: String) -> ValidationState {
        guard !confirmPassword.isEmpty else {
            return .idle
        }

        return password == confirmPassword
            ? .valid
            : .invalid("Passwords do not match")
    }

    /// Validates non-empty text
    public static func validateRequired(_ text: String, fieldName: String = "Field") -> ValidationState {
        guard !text.isEmpty else {
            return .invalid("\(fieldName) is required")
        }
        return .valid
    }

    /// Validates minimum length
    public static func validateMinLength(_ text: String, minLength: Int, fieldName: String = "Field") -> ValidationState {
        guard !text.isEmpty else {
            return .idle
        }

        return text.count >= minLength
            ? .valid
            : .invalid("\(fieldName) must be at least \(minLength) characters")
    }

    /// Validates maximum length
    public static func validateMaxLength(_ text: String, maxLength: Int, fieldName: String = "Field") -> ValidationState {
        guard !text.isEmpty else {
            return .idle
        }

        return text.count <= maxLength
            ? .valid
            : .invalid("\(fieldName) must be at most \(maxLength) characters")
    }

    /// Validates phone number format (basic US format)
    public static func validatePhoneNumber(_ phone: String) -> ValidationState {
        guard !phone.isEmpty else {
            return .idle
        }

        let phoneRegex = "^[\\+]?[(]?[0-9]{3}[)]?[-\\s\\.]?[0-9]{3}[-\\s\\.]?[0-9]{4,6}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)

        return phonePredicate.evaluate(with: phone)
            ? .valid
            : .invalid("Please enter a valid phone number")
    }

    /// Validates URL format
    public static func validateURL(_ urlString: String) -> ValidationState {
        guard !urlString.isEmpty else {
            return .idle
        }

        if let url = URL(string: urlString), url.scheme != nil, url.host != nil {
            return .valid
        }

        return .invalid("Please enter a valid URL")
    }

    /// Validates numeric input
    public static func validateNumeric(_ text: String) -> ValidationState {
        guard !text.isEmpty else {
            return .idle
        }

        return Double(text) != nil
            ? .valid
            : .invalid("Please enter a valid number")
    }

    /// Validates alphanumeric input
    public static func validateAlphanumeric(_ text: String) -> ValidationState {
        guard !text.isEmpty else {
            return .idle
        }

        let alphanumericRegex = "^[a-zA-Z0-9]+$"
        let alphanumericPredicate = NSPredicate(format: "SELF MATCHES %@", alphanumericRegex)

        return alphanumericPredicate.evaluate(with: text)
            ? .valid
            : .invalid("Only letters and numbers are allowed")
    }
}
