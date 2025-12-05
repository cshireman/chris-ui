//
//  SocialAuthDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

struct SocialAuthDemo: View {
    @State private var viewModel = SocialAuthViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Individual Buttons")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                SocialAuthButton(provider: .apple) {
                    Task {
                        await viewModel.handleSocialAuth(provider: .apple)
                    }
                }

                SocialAuthButton(provider: .google) {
                    Task {
                        await viewModel.handleSocialAuth(provider: .google)
                    }
                }

                SocialAuthButton(provider: .facebook) {
                    Task {
                        await viewModel.handleSocialAuth(provider: .facebook)
                    }
                }

                Text("Button Group")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)

                SocialAuthButtonGroup(
                    providers: [.apple, .google, .facebook],
                    onProviderSelected: { provider in
                        Task {
                            await viewModel.handleSocialAuth(provider: provider)
                        }
                    }
                )

                if viewModel.isLoading, let provider = viewModel.selectedProvider {
                    ProgressView("Authenticating with \(provider.displayName)...")
                        .padding()
                }
            }
            .padding()
        }
        .navigationTitle("Social Auth")
        .navigationBarTitleDisplayMode(.inline)
    }
}
