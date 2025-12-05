//
//  SocialAuthButton.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI
import AuthenticationServices
import GoogleSignInSwift
import FacebookLogin

/// Social authentication provider types
public enum SocialAuthProvider {
    case apple
    case google
    case facebook

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

/// A customizable social authentication button
public struct SocialAuthButton: View {
    let provider: SocialAuthProvider
    let action: () -> Void
    var style: ButtonStyle = .filled

    public enum ButtonStyle {
        case filled
        case outlined
    }

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
            } onCompletion: { result in
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

/// Container for multiple social auth buttons
public struct SocialAuthButtonGroup: View {
    let providers: [SocialAuthProvider]
    let onProviderSelected: (SocialAuthProvider) -> Void
    var style: SocialAuthButton.ButtonStyle = .filled
    var dividerText: String = "OR"

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

struct FacebookSignInButton: UIViewRepresentable {
    let permissions: [String]
    let action: () -> Void

    func makeUIView(context: Context) -> FBLoginButton {
        let button = FBLoginButton()
        button.permissions = permissions
        return button
    }

    func updateUIView(_ uiView: FBLoginButton, context: Context) {}
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
