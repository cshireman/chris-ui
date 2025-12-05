//
//  CustomTextField.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// Validation state for text fields


/// A customizable text field with validation states and styling
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
        self._text = text
        self.validation = validation
        self.keyboardType = keyboardType
        self.autocapitalization = autocapitalization
        self.isSecure = isSecure
        self.showVisibilityToggle = showVisibilityToggle
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.onTrailingIconTap = onTrailingIconTap
    }

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
