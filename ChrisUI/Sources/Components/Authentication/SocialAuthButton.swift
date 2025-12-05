//
//  SocialAuthButton.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import AuthenticationServices
import FacebookLogin
import GoogleSignInSwift
import SwiftUI

/// Supported social authentication provider types
///
/// Each provider integrates with their respective authentication SDK:
/// - Apple: Sign in with Apple using AuthenticationServices
/// - Google: Google Sign-In SDK
/// - Facebook: Facebook Login SDK
public enum SocialAuthProvider {
    case apple
    case google
    case facebook

    /// Human-readable name of the provider
    var displayName: String {
        switch self {
        case .apple:
            return "Apple"
        case .google:
            return "Google"
        case .facebook:
            return "Facebook"
        }
    }
}

/// A customizable social authentication button that integrates with platform-specific SDKs
///
/// This component provides pre-styled buttons for Apple, Google, and Facebook sign-in.
/// Each provider uses its native SDK for authentication, ensuring platform compliance
/// and consistent user experience.
///
/// Example:
/// ```swift
/// SocialAuthButton(provider: .apple) {
///     print("Apple login initiated")
/// }
/// ```
public struct SocialAuthButton: View {
    let provider: SocialAuthProvider
    let action: () -> Void
    var style: ButtonStyle = .filled

    /// Visual style options for the button
    public enum ButtonStyle {
        case filled
        case outlined
    }

    /// Creates a social authentication button
    /// - Parameters:
    ///   - provider: The authentication provider (Apple, Google, or Facebook)
    ///   - style: Visual style of the button (filled or outlined)
    ///   - action: Callback executed when authentication completes
    public init(
        provider: SocialAuthProvider,
        style: ButtonStyle = .filled,
        action: @escaping () -> Void
    ) {
        self.provider = provider
        self.style = style
        self.action = action
    }

    public var body: some View {
        if provider == .apple {
            SignInWithAppleButton(.continue) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { _ in
                action()
            }
            .frame(height: 50)
        } else if provider == .google {
            GoogleSignInButton(viewModel: .init(style: .standard), action: action)
        } else {
            FacebookSignInButton(permissions: ["public_profile", "email"], action: action).frame(height: 50)
        }
    }
}

/// Container for displaying multiple social authentication buttons with an optional divider
///
/// This component groups social auth buttons together with a customizable divider,
/// commonly used to separate social login from email/password authentication.
///
/// Example:
/// ```swift
/// SocialAuthButtonGroup(
///     providers: [.apple, .google, .facebook],
///     onProviderSelected: { provider in
///         handleAuthentication(with: provider)
///     }
/// )
/// ```
public struct SocialAuthButtonGroup: View {
    let providers: [SocialAuthProvider]
    let onProviderSelected: (SocialAuthProvider) -> Void
    var style: SocialAuthButton.ButtonStyle = .filled
    var dividerText: String = "OR"

    /// Creates a grouped social authentication button container
    /// - Parameters:
    ///   - providers: Array of authentication providers to display
    ///   - style: Visual style applied to all buttons
    ///   - dividerText: Text displayed in the divider (default: "OR")
    ///   - onProviderSelected: Callback executed when a provider is selected
    public init(
        providers: [SocialAuthProvider],
        style: SocialAuthButton.ButtonStyle = .filled,
        dividerText: String = "OR",
        onProviderSelected: @escaping (SocialAuthProvider) -> Void
    ) {
        self.providers = providers
        self.style = style
        self.dividerText = dividerText
        self.onProviderSelected = onProviderSelected
    }

    public var body: some View {
        VStack(spacing: 16) {
            // Divider
            HStack {
                Rectangle()
                    .fill(Color(.systemGray4))
                    .frame(height: 1)

                Text(dividerText)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 8)

                Rectangle()
                    .fill(Color(.systemGray4))
                    .frame(height: 1)
            }

            // Social Buttons
            ForEach(providers, id: \.self) { provider in
                SocialAuthButton(provider: provider, style: style) {
                    onProviderSelected(provider)
                }
            }
        }
    }
}

extension SocialAuthProvider: Hashable {}

/// UIViewRepresentable wrapper for Facebook's native login button
///
/// This component wraps the Facebook SDK's FBLoginButton to make it compatible
/// with SwiftUI. It handles the native Facebook login flow and permissions.
struct FacebookSignInButton: UIViewRepresentable {
    let permissions: [String]
    let action: () -> Void

    /// Creates the Facebook login button with specified permissions
    func makeUIView(context _: Context) -> FBLoginButton {
        let button = FBLoginButton()
        button.permissions = permissions
        return button
    }

    func updateUIView(_: FBLoginButton, context _: Context) {}
}

#Preview("Individual Buttons") {
    VStack(spacing: 16) {
        SocialAuthButton(provider: .apple) {
            print("Apple login")
        }

        SocialAuthButton(provider: .google) {
            print("Google login")
        }

        SocialAuthButton(provider: .facebook) {
            print("Facebook login")
        }
    }
    .padding()
}

#Preview("Button Group") {
    VStack {
        Spacer()

        SocialAuthButtonGroup(
            providers: [.apple, .google, .facebook],
            onProviderSelected: { provider in
                print("Selected: \(provider.displayName)")
            }
        )
        .padding()

        Spacer()
    }
}
