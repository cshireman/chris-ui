//
//  Validator.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import Foundation

/// Utility class providing common validation operations for form inputs
///
/// This enum provides static methods for validating various types of user input
/// including emails, passwords, phone numbers, URLs, and more. Each method returns
/// a ValidationState that can be used directly with form components.
///
/// Example:
/// ```swift
/// let emailState = Validator.validateEmail(email)
/// let passwordState = Validator.validatePassword(password, minLength: 8)
/// ```
public enum Validator {
    /// Validates email address format using regex pattern
    ///
    /// - Parameter email: The email string to validate
    /// - Returns: ValidationState indicating if the email is valid, invalid, or idle
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

    /// Validates password meets minimum length requirement
    ///
    /// - Parameters:
    ///   - password: The password string to validate
    ///   - minLength: Minimum required length (default: 8)
    /// - Returns: ValidationState indicating if the password meets requirements
    public static func validatePassword(_ password: String, minLength: Int = 8) -> ValidationState {
        guard !password.isEmpty else {
            return .idle
        }

        if password.count < minLength {
            return .invalid("Password must be at least \(minLength) characters")
        }

        return .valid
    }

    /// Validates that two password fields match
    ///
    /// - Parameters:
    ///   - password: The original password
    ///   - confirmPassword: The confirmation password to compare
    /// - Returns: ValidationState indicating if passwords match
    public static func validatePasswordMatch(_ password: String, _ confirmPassword: String) -> ValidationState {
        guard !confirmPassword.isEmpty else {
            return .idle
        }

        return password == confirmPassword
            ? .valid
            : .invalid("Passwords do not match")
    }

    /// Validates that a field is not empty
    ///
    /// - Parameters:
    ///   - text: The text to validate
    ///   - fieldName: Name of the field for error message (default: "Field")
    /// - Returns: ValidationState indicating if the field has content
    public static func validateRequired(_ text: String, fieldName: String = "Field") -> ValidationState {
        guard !text.isEmpty else {
            return .invalid("\(fieldName) is required")
        }
        return .valid
    }

    /// Validates that text meets minimum length requirement
    ///
    /// - Parameters:
    ///   - text: The text to validate
    ///   - minLength: Minimum required length
    ///   - fieldName: Name of the field for error message (default: "Field")
    /// - Returns: ValidationState indicating if text meets minimum length
    public static func validateMinLength(_ text: String, minLength: Int, fieldName: String = "Field") -> ValidationState {
        guard !text.isEmpty else {
            return .idle
        }

        return text.count >= minLength
            ? .valid
            : .invalid("\(fieldName) must be at least \(minLength) characters")
    }

    /// Validates that text does not exceed maximum length
    ///
    /// - Parameters:
    ///   - text: The text to validate
    ///   - maxLength: Maximum allowed length
    ///   - fieldName: Name of the field for error message (default: "Field")
    /// - Returns: ValidationState indicating if text is within maximum length
    public static func validateMaxLength(_ text: String, maxLength: Int, fieldName: String = "Field") -> ValidationState {
        guard !text.isEmpty else {
            return .idle
        }

        return text.count <= maxLength
            ? .valid
            : .invalid("\(fieldName) must be at most \(maxLength) characters")
    }

    /// Validates phone number format (supports US and international formats)
    ///
    /// - Parameter phone: The phone number string to validate
    /// - Returns: ValidationState indicating if the phone number is valid
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

    /// Validates URL format including scheme and host
    ///
    /// - Parameter urlString: The URL string to validate
    /// - Returns: ValidationState indicating if the URL is properly formatted
    public static func validateURL(_ urlString: String) -> ValidationState {
        guard !urlString.isEmpty else {
            return .idle
        }

        if let url = URL(string: urlString), url.scheme != nil, url.host != nil {
            return .valid
        }

        return .invalid("Please enter a valid URL")
    }

    /// Validates that text contains only numeric characters
    ///
    /// - Parameter text: The text to validate
    /// - Returns: ValidationState indicating if the text is a valid number
    public static func validateNumeric(_ text: String) -> ValidationState {
        guard !text.isEmpty else {
            return .idle
        }

        return Double(text) != nil
            ? .valid
            : .invalid("Please enter a valid number")
    }

    /// Validates that text contains only letters and numbers
    ///
    /// - Parameter text: The text to validate
    /// - Returns: ValidationState indicating if the text is alphanumeric
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
