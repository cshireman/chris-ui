//
//  NavigationRouter.swift
//  ChrisUI
//
//  Centralized navigation management using Swift's @Observable macro
//

import SwiftUI

/// Centralized navigation coordinator that manages the navigation path
///
/// This router follows the coordinator pattern, providing a single source of truth
/// for navigation state. It uses Swift's @Observable macro for automatic view updates
/// when the navigation path changes.
///
/// Usage:
/// ```swift
/// @State private var router = NavigationRouter()
///
/// NavigationStack(path: $router.path) {
///     // Root view
/// }
/// .environment(router)
/// ```
@Observable
final class NavigationRouter {
    // MARK: - Properties

    /// The current navigation path as a stack of routes
    var path: [Route] = []

    // MARK: - Initialization

    init() {}

    // MARK: - Navigation Actions

    /// Navigate to a specific route by pushing it onto the stack
    /// - Parameter route: The destination route to navigate to
    func navigate(to route: Route) {
        path.append(route)
    }

    /// Navigate back by popping the last route from the stack
    func navigateBack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    /// Navigate back to the root by clearing the entire path
    func navigateToRoot() {
        path.removeAll()
    }

    /// Navigate back to a specific route in the stack
    /// - Parameter route: The route to navigate back to
    /// - Returns: True if the route was found and navigation occurred, false otherwise
    @discardableResult
    func navigateBack(to route: Route) -> Bool {
        guard let index = path.firstIndex(of: route) else {
            return false
        }
        path.removeSubrange((index + 1)...)
        return true
    }

    /// Replace the current navigation path with a new route
    /// - Parameter route: The route to replace the current path with
    func replace(with route: Route) {
        path = [route]
    }
}
