//
//  Route.swift
//  ChrisUI
//
//  Navigation route definitions for type-safe navigation
//

import Foundation

/// Represents all possible navigation destinations in the ChrisUI component library
///
/// This enum provides type-safe navigation throughout the app, ensuring compile-time
/// verification of navigation paths and eliminating string-based navigation errors.
enum Route: Hashable {
    // MARK: - Authentication

    case loginScreen
    case signUpScreen
    case socialAuth

    // MARK: - Forms & Input

    case customTextFields
    case floatingLabelFields

    // MARK: - Buttons

    case gradientButtons
    case iconButtons
    case loadingButtons

    // MARK: - Cards

    case cardViews
    case profileCards

    // MARK: - Effects & Utilities

    case shimmerEffect
    case buttonStyles

    // MARK: - Metadata

    /// Human-readable title for the route, used in navigation bars
    var title: String {
        switch self {
        case .loginScreen: return "Login Screen"
        case .signUpScreen: return "Sign Up Screen"
        case .socialAuth: return "Social Auth Buttons"
        case .customTextFields: return "Custom Text Fields"
        case .floatingLabelFields: return "Floating Label Fields"
        case .gradientButtons: return "Gradient Buttons"
        case .iconButtons: return "Icon Buttons"
        case .loadingButtons: return "Loading Buttons"
        case .cardViews: return "Card Views"
        case .profileCards: return "Profile Cards"
        case .shimmerEffect: return "Shimmer Effect"
        case .buttonStyles: return "Button Styles"
        }
    }
}
