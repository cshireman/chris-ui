//
//  CustomTextField.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// A customizable text field with validation states and comprehensive styling options
///
/// This component provides a feature-rich text input field with built-in validation display,
/// icon support, password visibility toggle, and customizable styling. It automatically
/// displays validation icons and error messages based on the validation state.
///
/// Example:
/// ```swift
/// CustomTextField(
///     title: "Email",
///     placeholder: "Enter your email",
///     text: $email,
///     validation: .valid,
///     keyboardType: .emailAddress,
///     leadingIcon: "envelope"
/// )
/// ```
///
/// Features:
/// - Title label and placeholder text
/// - Validation state indicators (idle, valid, invalid)
/// - Leading and trailing icon support
/// - Secure text entry with visibility toggle
/// - Automatic keyboard type configuration
/// - Error message display
public struct CustomTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    var validation: ValidationState = .idle
    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .sentences
    var isSecure: Bool = false
    var showVisibilityToggle: Bool = false
    var leadingIcon: String?
    var trailingIcon: String?
    var onTrailingIconTap: (() -> Void)?

    @State private var isPasswordVisible: Bool = false

    /// Creates a custom text field with validation support
    /// - Parameters:
    ///   - title: The label displayed above the field
    ///   - placeholder: Placeholder text shown when empty
    ///   - text: Binding to the text value
    ///   - validation: Current validation state (default: idle)
    ///   - keyboardType: Keyboard type to display (default: default)
    ///   - autocapitalization: Auto-capitalization behavior (default: sentences)
    ///   - isSecure: Whether to use secure text entry (default: false)
    ///   - showVisibilityToggle: Show password visibility toggle for secure fields (default: false)
    ///   - leadingIcon: Optional SF Symbol to display before the text
    ///   - trailingIcon: Optional SF Symbol to display after the text
    ///   - onTrailingIconTap: Action to execute when trailing icon is tapped
    public init(
        title: String,
        placeholder: String,
        text: Binding<String>,
        validation: ValidationState = .idle,
        keyboardType: UIKeyboardType = .default,
        autocapitalization: TextInputAutocapitalization = .sentences,
        isSecure: Bool = false,
        showVisibilityToggle: Bool = false,
        leadingIcon: String? = nil,
        trailingIcon: String? = nil,
        onTrailingIconTap: (() -> Void)? = nil
    ) {
        self.title = title
        self.placeholder = placeholder
        _text = text
        self.validation = validation
        self.keyboardType = keyboardType
        self.autocapitalization = autocapitalization
        self.isSecure = isSecure
        self.showVisibilityToggle = showVisibilityToggle
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.onTrailingIconTap = onTrailingIconTap
    }

    /// Determines the border color based on the validation state
    private var borderColor: Color {
        switch validation {
        case .idle:
            return Color(.systemGray4)
        case .valid:
            return .green
        case .invalid:
            return .red
        }
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Title
            if !title.isEmpty {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
            }

            // Text Field Container
            HStack(spacing: 12) {
                // Leading Icon
                if let leadingIcon = leadingIcon {
                    Image(systemName: leadingIcon)
                        .foregroundStyle(.secondary)
                }

                // Text Field
                Group {
                    if isSecure && !isPasswordVisible {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .textFieldStyle(.plain)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(autocapitalization)
                .autocorrectionDisabled(keyboardType == .emailAddress)

                // Trailing Icons
                HStack(spacing: 8) {
                    // Validation Icon
                    if case .valid = validation {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    } else if case .invalid = validation {
                        Image(systemName: "exclamationmark.circle.fill")
                            .foregroundStyle(.red)
                    }

                    // Visibility Toggle
                    if showVisibilityToggle && isSecure {
                        Button(action: { isPasswordVisible.toggle() }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundStyle(.secondary)
                        }
                    }

                    // Custom Trailing Icon
                    if let trailingIcon = trailingIcon {
                        Button(action: { onTrailingIconTap?() }) {
                            Image(systemName: trailingIcon)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1.5)
            )

            // Error Message
            if let errorMessage = validation.errorMessage {
                HStack(spacing: 4) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.caption)
                    Text(errorMessage)
                        .font(.caption)
                }
                .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    VStack(spacing: 24) {
        CustomTextField(
            title: "Email",
            placeholder: "Enter your email",
            text: .constant(""),
            leadingIcon: "envelope"
        )

        CustomTextField(
            title: "Email",
            placeholder: "Enter your email",
            text: .constant("user@example.com"),
            validation: .valid,
            keyboardType: .emailAddress,
            autocapitalization: .never,
            leadingIcon: "envelope"
        )

        CustomTextField(
            title: "Email",
            placeholder: "Enter your email",
            text: .constant("invalid-email"),
            validation: .invalid("Please enter a valid email address"),
            keyboardType: .emailAddress,
            autocapitalization: .never,
            leadingIcon: "envelope"
        )

        CustomTextField(
            title: "Password",
            placeholder: "Enter your password",
            text: .constant("password123"),
            isSecure: true,
            showVisibilityToggle: true,
            leadingIcon: "lock"
        )

        CustomTextField(
            title: "Search",
            placeholder: "Search...",
            text: .constant(""),
            leadingIcon: "magnifyingglass",
            trailingIcon: "xmark.circle.fill",
            onTrailingIconTap: {
                print("Clear tapped")
            }
        )
    }
    .padding()
}
