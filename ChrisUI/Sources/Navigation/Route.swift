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

    // MARK: - Lists & Collections

    case pullToRefreshList
    case infiniteScrollList
    case swipeableListRow
    case expandableList
    case gridLayout
    case horizontalScrollPicker
    case reorderableList
    case emptyStateView

    // MARK: - Charts & Visualizations

    case lineChart
    case barChart
    case pieChart
    case donutChart
    case progressRing
    case sparkline
    case gaugeView
    case heatMap

    // MARK: - E-commerce

    case productGrid
    case addToCartButton
    case quantitySelector
    case priceTag
    case discountBadge
    case sizeSelector
    case colorSwatch
    case checkoutProgress
    case orderStatus

    // MARK: - Effects & Utilities

    case shimmerEffect
    case buttonStyles

    // MARK: - Metadata

    /// Human-readable title for the route, used in navigation bars
    var title: String {
        switch self {
        // Authentication
        case .loginScreen: return "Login Screen"
        case .signUpScreen: return "Sign Up Screen"
        case .socialAuth: return "Social Auth Buttons"
        // Forms & Input
        case .customTextFields: return "Custom Text Fields"
        case .floatingLabelFields: return "Floating Label Fields"
        // Buttons
        case .gradientButtons: return "Gradient Buttons"
        case .iconButtons: return "Icon Buttons"
        case .loadingButtons: return "Loading Buttons"
        // Cards
        case .cardViews: return "Card Views"
        case .profileCards: return "Profile Cards"
        // Lists & Collections
        case .pullToRefreshList: return "Pull to Refresh List"
        case .infiniteScrollList: return "Infinite Scroll List"
        case .swipeableListRow: return "Swipeable List Row"
        case .expandableList: return "Expandable List"
        case .gridLayout: return "Grid Layout"
        case .horizontalScrollPicker: return "Horizontal Scroll Picker"
        case .reorderableList: return "Reorderable List"
        case .emptyStateView: return "Empty State View"
        // Charts & Visualizations
        case .lineChart: return "Line Chart"
        case .barChart: return "Bar Chart"
        case .pieChart: return "Pie Chart"
        case .donutChart: return "Donut Chart"
        case .progressRing: return "Progress Ring"
        case .sparkline: return "Sparkline"
        case .gaugeView: return "Gauge View"
        case .heatMap: return "Heat Map"
        // E-commerce
        case .productGrid: return "Product Grid"
        case .addToCartButton: return "Add to Cart Button"
        case .quantitySelector: return "Quantity Selector"
        case .priceTag: return "Price Tag"
        case .discountBadge: return "Discount Badge"
        case .sizeSelector: return "Size Selector"
        case .colorSwatch: return "Color Swatch"
        case .checkoutProgress: return "Checkout Progress"
        case .orderStatus: return "Order Status"
        // Effects & Utilities
        case .shimmerEffect: return "Shimmer Effect"
        case .buttonStyles: return "Button Styles"
        }
    }
}
