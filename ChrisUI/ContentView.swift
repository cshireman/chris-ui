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
        // Lists & Collections
        case .pullToRefreshList:
            PullToRefreshListDemo()
        case .infiniteScrollList:
            InfiniteScrollListDemo()
        case .swipeableListRow:
            SwipeableListRowDemo()
        case .expandableList:
            ExpandableListDemo()
        case .gridLayout:
            GridLayoutDemo()
        case .horizontalScrollPicker:
            HorizontalScrollPickerDemo()
        case .reorderableList:
            ReorderableListDemo()
        case .emptyStateView:
            EmptyStateViewDemo()
        // Charts & Visualizations
        case .lineChart:
            if #available(iOS 16.0, *) {
                LineChartDemo()
            } else {
                Text("Line Chart requires iOS 16+")
            }
        case .barChart:
            if #available(iOS 16.0, *) {
                BarChartDemo()
            } else {
                Text("Bar Chart requires iOS 16+")
            }
        case .pieChart:
            PieChartDemo()
        case .donutChart:
            DonutChartDemo()
        case .progressRing:
            ProgressRingDemo()
        case .sparkline:
            SparklineDemo()
        case .gaugeView:
            GaugeViewDemo()
        case .heatMap:
            HeatMapDemo()
        // E-commerce
        case .productGrid:
            ProductGridDemo()
        case .addToCartButton:
            AddToCartButtonDemo()
        case .quantitySelector:
            QuantitySelectorDemo()
        case .priceTag:
            PriceTagDemo()
        case .discountBadge:
            DiscountBadgeDemo()
        case .sizeSelector:
            SizeSelectorDemo()
        case .colorSwatch:
            ColorSwatchDemo()
        case .checkoutProgress:
            CheckoutProgressDemo()
        case .orderStatus:
            OrderStatusDemo()
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

            Section("Lists & Collections") {
                NavigationRow(route: .pullToRefreshList)
                NavigationRow(route: .infiniteScrollList)
                NavigationRow(route: .swipeableListRow)
                NavigationRow(route: .expandableList)
                NavigationRow(route: .gridLayout)
                NavigationRow(route: .horizontalScrollPicker)
                NavigationRow(route: .reorderableList)
                NavigationRow(route: .emptyStateView)
            }

            Section("Charts & Visualizations") {
                NavigationRow(route: .lineChart)
                NavigationRow(route: .barChart)
                NavigationRow(route: .pieChart)
                NavigationRow(route: .donutChart)
                NavigationRow(route: .progressRing)
                NavigationRow(route: .sparkline)
                NavigationRow(route: .gaugeView)
                NavigationRow(route: .heatMap)
            }

            Section("E-commerce") {
                NavigationRow(route: .productGrid)
                NavigationRow(route: .addToCartButton)
                NavigationRow(route: .quantitySelector)
                NavigationRow(route: .priceTag)
                NavigationRow(route: .discountBadge)
                NavigationRow(route: .sizeSelector)
                NavigationRow(route: .colorSwatch)
                NavigationRow(route: .checkoutProgress)
                NavigationRow(route: .orderStatus)
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
