//
//  AddToCartViewModel.swift
//  ChrisUI
//
//  View model for managing add to cart state
//

import Foundation

/// View model for managing shopping cart state
///
/// This observable class manages cart items and provides methods
/// for adding/removing products from the cart.
@Observable
public class AddToCartViewModel {
    /// Items currently in the cart
    public var cartItems: Set<String> = []
    /// Whether a cart operation is in progress
    public var isLoading: Bool = false

    /// Initializes the view model
    public init() {}

    /// Checks if an item is in the cart
    /// - Parameter itemId: The item identifier
    /// - Returns: Whether the item is in the cart
    public func isInCart(_ itemId: String) -> Bool {
        cartItems.contains(itemId)
    }

    /// Adds an item to the cart
    /// - Parameter itemId: The item identifier
    public func addToCart(_ itemId: String) async {
        isLoading = true

        // Simulate API call
        try? await Task.sleep(for: .seconds(0.5))

        cartItems.insert(itemId)
        isLoading = false
    }

    /// Removes an item from the cart
    /// - Parameter itemId: The item identifier
    public func removeFromCart(_ itemId: String) {
        cartItems.remove(itemId)
    }

    /// Clears all items from the cart
    public func clearCart() {
        cartItems.removeAll()
    }

    /// Total number of items in cart
    public var itemCount: Int {
        cartItems.count
    }
}
