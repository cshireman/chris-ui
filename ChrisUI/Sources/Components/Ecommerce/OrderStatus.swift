//
//  OrderStatus.swift
//  ChrisUI
//
//  A delivery tracking view component
//

import SwiftUI

/// A component for displaying order delivery status and tracking
///
/// This component shows the current status of an order with a visual
/// timeline, tracking information, and estimated delivery.
///
/// Example:
/// ```swift
/// OrderStatus(
///     order: currentOrder,
///     timeline: orderTimeline
/// )
/// ```
public struct OrderStatus: View {
    private let orderNumber: String
    private let currentStatus: OrderStatusType
    private let timeline: [TimelineEvent]
    private let estimatedDelivery: Date?

    /// Creates an order status view
    /// - Parameters:
    ///   - orderNumber: Order number/ID
    ///   - currentStatus: Current order status
    ///   - timeline: Array of timeline events
    ///   - estimatedDelivery: Estimated delivery date
    public init(
        orderNumber: String,
        currentStatus: OrderStatusType,
        timeline: [TimelineEvent],
        estimatedDelivery: Date? = nil
    ) {
        self.orderNumber = orderNumber
        self.currentStatus = currentStatus
        self.timeline = timeline
        self.estimatedDelivery = estimatedDelivery
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            headerSection
            statusBadge
            if let delivery = estimatedDelivery {
                deliveryEstimate(delivery)
            }
            timelineSection
        }
        .padding()
    }

    // MARK: - Subviews

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Order #\(orderNumber)")
                .font(.title2)
                .fontWeight(.bold)

            Text(currentStatus.displayText)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var statusBadge: some View {
        HStack {
            Image(systemName: currentStatus.icon)
                .foregroundStyle(currentStatus.color)

            Text(currentStatus.rawValue)
                .font(.subheadline)
                .fontWeight(.semibold)

            Spacer()
        }
        .padding()
        .background(currentStatus.color.opacity(0.1))
        .cornerRadius(12)
    }

    private func deliveryEstimate(_ date: Date) -> some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundStyle(.secondary)

            Text("Estimated delivery: \(date, style: .date)")
                .font(.subheadline)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }

    private var timelineSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Tracking History")
                .font(.headline)

            VStack(alignment: .leading, spacing: 16) {
                ForEach(Array(timeline.enumerated()), id: \.element.id) { index, event in
                    timelineRow(event: event, isLast: index == timeline.count - 1)
                }
            }
        }
    }

    private func timelineRow(event: TimelineEvent, isLast: Bool) -> some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(spacing: 0) {
                Circle()
                    .fill(event.isCompleted ? Color.green : Color(.systemGray4))
                    .frame(width: 12, height: 12)

                if !isLast {
                    Rectangle()
                        .fill(event.isCompleted ? Color.green.opacity(0.3) : Color(.systemGray5))
                        .frame(width: 2)
                        .frame(height: 40)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.subheadline)
                    .fontWeight(event.isCompleted ? .semibold : .regular)

                if let description = event.description {
                    Text(description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                if let date = event.date {
                    Text(date, style: .date)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
    }

    // MARK: - Order Status Type

    public enum OrderStatusType: String {
        case placed = "Order Placed"
        case confirmed = "Confirmed"
        case processing = "Processing"
        case shipped = "Shipped"
        case outForDelivery = "Out for Delivery"
        case delivered = "Delivered"
        case cancelled = "Cancelled"

        var icon: String {
            switch self {
            case .placed: return "checkmark.circle"
            case .confirmed: return "checkmark.circle.fill"
            case .processing: return "gear"
            case .shipped: return "shippingbox"
            case .outForDelivery: return "truck.box"
            case .delivered: return "checkmark.seal.fill"
            case .cancelled: return "xmark.circle"
            }
        }

        var color: Color {
            switch self {
            case .placed, .confirmed: return .blue
            case .processing: return .orange
            case .shipped, .outForDelivery: return .purple
            case .delivered: return .green
            case .cancelled: return .red
            }
        }

        var displayText: String {
            switch self {
            case .delivered: return "Your order has been delivered"
            case .outForDelivery: return "Your order is out for delivery"
            case .shipped: return "Your order has been shipped"
            case .processing: return "We're preparing your order"
            case .confirmed: return "Your order is confirmed"
            case .placed: return "Your order has been placed"
            case .cancelled: return "Your order has been cancelled"
            }
        }
    }
}

// MARK: - Timeline Event

/// Represents an event in the order timeline
public struct TimelineEvent: Identifiable {
    public let id = UUID()
    public let title: String
    public let description: String?
    public let date: Date?
    public let isCompleted: Bool

    public init(
        title: String,
        description: String? = nil,
        date: Date? = nil,
        isCompleted: Bool = false
    ) {
        self.title = title
        self.description = description
        self.date = date
        self.isCompleted = isCompleted
    }
}

#Preview {
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

    return ScrollView {
        OrderStatus(
            orderNumber: "12345678",
            currentStatus: .shipped,
            timeline: timeline,
            estimatedDelivery: Date().addingTimeInterval(86400)
        )
    }
}
