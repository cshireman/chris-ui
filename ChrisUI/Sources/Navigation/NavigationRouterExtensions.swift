//
//  NavigationRouterExtensions.swift
//  ChrisUI
//
//  Convenient extensions for NavigationRouter usage
//

import SwiftUI

// MARK: - Environment Key

extension EnvironmentValues {
    /// Environment key for accessing the NavigationRouter
    ///
    /// This allows any view in the hierarchy to access the router for programmatic navigation:
    /// ```swift
    /// @Environment(NavigationRouter.self) private var router
    ///
    /// Button("Go to Login") {
    ///     router.navigate(to: .loginScreen)
    /// }
    /// ```
    @Entry var navigationRouter: NavigationRouter = NavigationRouter()
}

// MARK: - View Extensions

extension View {
    /// Injects a NavigationRouter into the environment
    /// - Parameter router: The router to inject
    /// - Returns: A view with the router available in its environment
    func navigationRouter(_ router: NavigationRouter) -> some View {
        environment(router)
    }
}
