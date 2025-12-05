//
//  ContentView.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// Root view of the ChrisUI component library demo app
///
/// This view uses NavigationStack with a type-safe routing system to navigate
/// between different component demos. The navigation state is managed by
/// NavigationRouter, which provides programmatic navigation capabilities.
struct ContentView: View {
    // MARK: - Properties

    @State private var router = NavigationRouter()

    // MARK: - Body

    var body: some View {
        NavigationStack(path: $router.path) {
            ComponentListView()
                .navigationTitle("ChrisUI Components")
                .navigationDestination(for: Route.self) { route in
                    destinationView(for: route)
                        .navigationTitle(route.title)
                }
        }
        .environment(router)
    }

    // MARK: - Destination Views

    /// Maps a route to its corresponding destination view
    /// - Parameter route: The route to display
    /// - Returns: The SwiftUI view for the given route
    @ViewBuilder
    private func destinationView(for route: Route) -> some View {
        switch route {
        // Authentication
        case .loginScreen:
            LoginScreenDemo()
        case .signUpScreen:
            SignUpScreenDemo()
        case .socialAuth:
            SocialAuthDemo()
        // Forms & Input
        case .customTextFields:
            TextFieldDemo()
        case .floatingLabelFields:
            FloatingLabelDemo()
        // Buttons
        case .gradientButtons:
            GradientButtonDemo()
        case .iconButtons:
            IconButtonDemo()
        case .loadingButtons:
            LoadingButtonDemo()
        // Cards
        case .cardViews:
            CardViewDemo()
        case .profileCards:
            ProfileCardDemo()
        // Effects & Utilities
        case .shimmerEffect:
            ShimmerEffectDemo()
        case .buttonStyles:
            ButtonStyleDemo()
        }
    }
}

// MARK: - Component List View

/// Displays the list of available component demos organized by category
private struct ComponentListView: View {
    @Environment(NavigationRouter.self) private var router

    var body: some View {
        List {
            Section("Authentication") {
                NavigationRow(route: .loginScreen)
                NavigationRow(route: .signUpScreen)
                NavigationRow(route: .socialAuth)
            }

            Section("Forms & Input") {
                NavigationRow(route: .customTextFields)
                NavigationRow(route: .floatingLabelFields)
            }

            Section("Buttons") {
                NavigationRow(route: .gradientButtons)
                NavigationRow(route: .iconButtons)
                NavigationRow(route: .loadingButtons)
            }

            Section("Cards") {
                NavigationRow(route: .cardViews)
                NavigationRow(route: .profileCards)
            }

            Section("Effects & Utilities") {
                NavigationRow(route: .shimmerEffect)
                NavigationRow(route: .buttonStyles)
            }
        }
    }
}

// MARK: - Navigation Row

/// Reusable row component for navigation items
///
/// This component creates a tappable row that navigates to a specific route
/// when selected. It uses the NavigationLink with a value-based approach
/// for type-safe navigation.
private struct NavigationRow: View {
    let route: Route

    var body: some View {
        NavigationLink(value: route) {
            Text(route.title)
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
