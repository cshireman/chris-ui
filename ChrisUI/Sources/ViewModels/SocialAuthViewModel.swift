//
//  SocialAuthViewModel.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import Foundation
import Combine

@Observable
class SocialAuthViewModel {
    var isLoading: Bool = false
    var selectedProvider: SocialAuthProvider?

    func handleSocialAuth(provider: SocialAuthProvider) async {
        isLoading = true
        selectedProvider = provider

        // Simulate authentication
        try? await Task.sleep(nanoseconds: 1_000_000_000)

        print("Authenticated with: \(provider.displayName)")

        isLoading = false
        selectedProvider = nil
    }
}
