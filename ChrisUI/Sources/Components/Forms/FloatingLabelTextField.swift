//
//  FloatingLabelTextField.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// Material Design-style floating label text field with smooth animations
///
/// This component implements the Material Design floating label pattern where
/// the placeholder animates to become a label above the field when focused or filled.
/// It provides a modern, space-efficient alternative to traditional labeled inputs.
///
/// Example:
/// ```swift
/// FloatingLabelTextField(
///     placeholder: "Email",
///     text: $email,
///     keyboardType: .emailAddress,
///     autocapitalization: .never,
///     validation: emailValidation
/// )
/// ```
///
/// Features:
/// - Smooth label animation on focus/blur
/// - Validation state with colored borders
/// - Secure text entry support
/// - Customizable keyboard types
/// - Error message display
public struct FloatingLabelTextField: View {
    let placeholder: String
    @Binding var text: String

    var keyboardType: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .sentences
    var isSecure: Bool = false
    var validation: ValidationState = .idle

    @FocusState private var isFocused: Bool

    /// Creates a floating label text field
    /// - Parameters:
    ///   - placeholder: The placeholder/label text
    ///   - text: Binding to the text value
    ///   - keyboardType: Keyboard type to display (default: default)
    ///   - autocapitalization: Auto-capitalization behavior (default: sentences)
    ///   - isSecure: Whether to use secure text entry (default: false)
    ///   - validation: Current validation state (default: idle)
    public init(
        placeholder: String,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        autocapitalization: TextInputAutocapitalization = .sentences,
        isSecure: Bool = false,
        validation: ValidationState = .idle
    ) {
        self.placeholder = placeholder
        _text = text
        self.keyboardType = keyboardType
        self.autocapitalization = autocapitalization
        self.isSecure = isSecure
        self.validation = validation
    }

    /// Determines whether the label should float above the field
    private var shouldFloat: Bool {
        isFocused || !text.isEmpty
    }

    /// Determines the border color based on focus and validation state
    private var borderColor: Color {
        if isFocused {
            return focusedValidationColor
        }

        switch validation {
        case .idle:
            return Color(.systemGray4)
        case .valid:
            return .green
        case .invalid:
            return .red
        }
    }

    /// Determines the label color based on focus state
    private var labelColor: Color {
        isFocused ? focusedValidationColor : .secondary
    }

    /// Determines the accent color when focused based on validation state
    private var focusedValidationColor: Color {
        switch validation {
        case .idle, .valid:
            return .accentColor
        case .invalid:
            return .red
        }
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            floatingTextField

            if let errorMessage = validation.errorMessage {
                errorMessageLabel(errorMessage)
            }
        }
    }

    private var floatingTextField: some View {
        ZStack(alignment: .leading) {
            floatingLabel
            textField
        }
        .contentShape(Rectangle())
        .onTapGesture { isFocused = true }
        .padding(.top, 16)
        .padding(.bottom, 8)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemBackground))
        )
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(borderColor, lineWidth: isFocused ? 2 : 1)
        )
    }

    private var floatingLabel: some View {
        Text(placeholder)
            .font(shouldFloat ? .caption : .body)
            .foregroundStyle(labelColor)
            .padding(.horizontal, shouldFloat ? 4 : 0)
            .background(
                Group {
                    if shouldFloat {
                        Color(.systemBackground)
                    }
                }
            )
            .offset(y: shouldFloat ? -28 : -4)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: shouldFloat)
            .zIndex(1)
            .allowsHitTesting(false)
    }

    private var textField: some View {
        Group {
            if isSecure {
                SecureField("", text: $text)
            } else {
                TextField("", text: $text)
            }
        }
        .padding(.bottom, 6)
        .textFieldStyle(.plain)
        .keyboardType(keyboardType)
        .textInputAutocapitalization(autocapitalization)
        .focused($isFocused)
        .overlay(alignment: .leading) {
            if !shouldFloat {
                Text(placeholder)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 8)
            }
        }
    }

    private func errorMessageLabel(_ errorMessage: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: "exclamationmark.circle.fill")
                .font(.caption)
            Text(errorMessage)
                .font(.caption)
        }
        .foregroundStyle(.red)
        .padding(.leading, 12)
    }
}

#Preview {
    VStack(spacing: 32) {
        FloatingLabelTextField(
            placeholder: "Email",
            text: .constant(""),
            keyboardType: .emailAddress,
            autocapitalization: .never
        )

        FloatingLabelTextField(
            placeholder: "Email",
            text: .constant("user@example.com"),
            keyboardType: .emailAddress,
            autocapitalization: .never,
            validation: .valid
        )

        FloatingLabelTextField(
            placeholder: "Email",
            text: .constant("invalid"),
            keyboardType: .emailAddress,
            autocapitalization: .never,
            validation: .invalid("Invalid email format")
        )

        FloatingLabelTextField(
            placeholder: "Password",
            text: .constant(""),
            isSecure: true
        )
    }
    .padding()
}
