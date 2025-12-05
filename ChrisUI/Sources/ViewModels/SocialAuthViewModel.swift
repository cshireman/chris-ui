//
//  SocialAuthViewModel.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import Combine
import Foundation

/// View model for managing social authentication state
///
/// This observable class manages state for social authentication flows,
/// tracking loading states and the currently selected provider.
@Observable
class SocialAuthViewModel {
    /// Indicates whether an authentication request is in progress
    var isLoading: Bool = false
    /// The currently selected authentication provider
    var selectedProvider: SocialAuthProvider?

    /// Handles social authentication for a specific provider
    ///
    /// This async method simulates the authentication flow for the selected provider.
    /// In a real app, this would integrate with the provider's SDK and handle callbacks.
    /// - Parameter provider: The social authentication provider (Apple, Google, or Facebook)
    func handleSocialAuth(provider: SocialAuthProvider) async {
        isLoading = true
        selectedProvider = provider

        // Simulate authentication
        try? await Task.sleep(for: .seconds(1))

        print("Authenticated with: \(provider.displayName)")

        isLoading = false
        selectedProvider = nil
    }
}
