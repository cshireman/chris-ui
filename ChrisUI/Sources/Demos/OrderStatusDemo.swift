//
//  OrderStatusDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demonstrates the OrderStatus component with timeline tracking
struct OrderStatusDemo: View {
    let timeline = [
        TimelineEvent(
            title: "Order Placed",
            description: "We have received your order",
            date: Date().addingTimeInterval(-86400 * 3),
            isCompleted: true
        ),
        TimelineEvent(
            title: "Order Confirmed",
            description: "Your order has been confirmed",
            date: Date().addingTimeInterval(-86400 * 2),
            isCompleted: true
        ),
        TimelineEvent(
            title: "Shipped",
            description: "Your package is on its way",
            date: Date().addingTimeInterval(-86400),
            isCompleted: true
        ),
        TimelineEvent(
            title: "Out for Delivery",
            description: "Package is with the delivery partner",
            date: nil,
            isCompleted: false
        ),
        TimelineEvent(
            title: "Delivered",
            description: nil,
            date: nil,
            isCompleted: false
        )
    ]

    var body: some View {
        ScrollView {
            OrderStatus(
                orderNumber: "12345678",
                currentStatus: .shipped,
                timeline: timeline,
                estimatedDelivery: Date().addingTimeInterval(86400)
            )
        }
        .navigationTitle("Order Status")
    }
}

#Preview {
    NavigationStack {
        OrderStatusDemo()
    }
}
