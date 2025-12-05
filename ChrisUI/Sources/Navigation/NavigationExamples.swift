//
//  NavigationExamples.swift
//  ChrisUI
//
//  Example patterns for using the navigation system
//

import SwiftUI

// MARK: - Example 1: Programmatic Navigation After Action

/// Example showing how to navigate programmatically after completing an action
struct ProgrammaticNavigationExample: View {
    @Environment(NavigationRouter.self) private var router
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Complete this action to navigate")
                .font(.headline)

            Button("Complete Action") {
                performAction()
            }
            .disabled(isLoading)
        }
        .padding()
    }

    private func performAction() {
        isLoading = true

        // Simulate async operation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isLoading = false
            // Navigate after completion
            router.navigate(to: .loginScreen)
        }
    }
}

// MARK: - Example 2: Conditional Navigation

/// Example showing conditional navigation based on state
struct ConditionalNavigationExample: View {
    @Environment(NavigationRouter.self) private var router
    @State private var isAuthenticated = false

    var body: some View {
        VStack(spacing: 20) {
            Toggle("Authenticated", isOn: $isAuthenticated)

            Button("Proceed") {
                handleProceed()
            }
        }
        .padding()
    }

    private func handleProceed() {
        if isAuthenticated {
            router.navigate(to: .profileCards)
        } else {
            router.navigate(to: .loginScreen)
        }
    }
}

// MARK: - Example 3: Multi-Step Flow

/// Example showing a multi-step flow with navigation
struct MultiStepFlowExample: View {
    @Environment(NavigationRouter.self) private var router
    @State private var currentStep = 1

    var body: some View {
        VStack(spacing: 20) {
            Text("Step \(currentStep) of 3")
                .font(.headline)

            Button("Next Step") {
                handleNextStep()
            }
        }
        .padding()
    }

    private func handleNextStep() {
        currentStep += 1

        switch currentStep {
        case 2:
            router.navigate(to: .signUpScreen)
        case 3:
            router.navigate(to: .socialAuth)
        default:
            router.navigateToRoot()
        }
    }
}

// MARK: - Example 4: Deep Link Navigation

/// Example showing how to handle deep links
struct DeepLinkExample: View {
    @Environment(NavigationRouter.self) private var router

    var body: some View {
        VStack(spacing: 20) {
            Button("Simulate Deep Link") {
                handleDeepLink(url: URL(string: "chrisui://profile/settings")!)
            }
        }
        .padding()
    }

    private func handleDeepLink(url: URL) {
        // Parse URL and navigate to appropriate screens
        let pathComponents = url.pathComponents.filter { $0 != "/" }

        switch pathComponents.first {
        case "profile":
            if pathComponents.contains("settings") {
                router.path = [.profileCards, .buttonStyles]
            } else {
                router.navigate(to: .profileCards)
            }
        case "login":
            router.replace(with: .loginScreen)
        default:
            router.navigateToRoot()
        }
    }
}

// MARK: - Example 5: Navigation with Validation

/// Example showing navigation with form validation
struct ValidationNavigationExample: View {
    @Environment(NavigationRouter.self) private var router
    @State private var username = ""
    @State private var showError = false

    var body: some View {
        VStack(spacing: 20) {
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)

            if showError {
                Text("Username is required")
                    .foregroundStyle(.red)
                    .font(.caption)
            }

            Button("Continue") {
                handleContinue()
            }
        }
        .padding()
    }

    private func handleContinue() {
        guard !username.isEmpty else {
            showError = true
            return
        }

        showError = false
        router.navigate(to: .signUpScreen)
    }
}

// MARK: - Example 6: Back Navigation with Confirmation

/// Example showing how to navigate back with confirmation
struct ConfirmBackNavigationExample: View {
    @Environment(NavigationRouter.self) private var router
    @State private var hasUnsavedChanges = true
    @State private var showConfirmation = false

    var body: some View {
        VStack(spacing: 20) {
            Text("You have unsaved changes")
                .font(.headline)

            Button("Go Back") {
                handleBack()
            }
        }
        .padding()
        .alert("Unsaved Changes", isPresented: $showConfirmation) {
            Button("Discard", role: .destructive) {
                router.navigateBack()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to discard your changes?")
        }
    }

    private func handleBack() {
        if hasUnsavedChanges {
            showConfirmation = true
        } else {
            router.navigateBack()
        }
    }
}

// MARK: - Example 7: Replace Navigation Stack

/// Example showing how to replace the entire navigation stack
struct ReplaceStackExample: View {
    @Environment(NavigationRouter.self) private var router

    var body: some View {
        VStack(spacing: 20) {
            Button("Reset to Login") {
                // Clear all navigation and go to login
                router.replace(with: .loginScreen)
            }

            Button("Logout") {
                // Perform logout and return to root
                performLogout()
            }
        }
        .padding()
    }

    private func performLogout() {
        // Clear user data, tokens, etc.
        // Then navigate to root
        router.navigateToRoot()
    }
}

// MARK: - Example 8: Accessing Router in Child Views

/// Parent view that sets up navigation
struct ParentViewExample: View {
    var body: some View {
        VStack {
            ChildViewExample()
        }
    }
}

/// Child view that accesses the router from environment
struct ChildViewExample: View {
    @Environment(NavigationRouter.self) private var router

    var body: some View {
        Button("Navigate from Child") {
            router.navigate(to: .gradientButtons)
        }
    }
}

// MARK: - Preview Examples

#Preview("Programmatic Navigation") {
    NavigationStack {
        ProgrammaticNavigationExample()
    }
    .environment(NavigationRouter())
}

#Preview("Conditional Navigation") {
    NavigationStack {
        ConditionalNavigationExample()
    }
    .environment(NavigationRouter())
}

#Preview("Multi-Step Flow") {
    NavigationStack {
        MultiStepFlowExample()
    }
    .environment(NavigationRouter())
}
