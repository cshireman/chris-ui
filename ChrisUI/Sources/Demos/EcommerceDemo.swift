//
//  EcommerceDemo.swift
//  ChrisUI
//
//  Demonstrations for all E-commerce components
//

import SwiftUI

// MARK: - Product Grid Demo

struct ProductGridDemo: View {
    let products = (0..<12).map { i in
        ProductData(
            name: "Product \(i + 1)",
            price: Double.random(in: 19.99...299.99),
            rating: Double.random(in: 3.5...5.0)
        )
    }

    var body: some View {
        ProductGrid(products: products) { product in
            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.1))
                    .frame(height: 150)
                    .overlay {
                        Image(systemName: "photo")
                            .font(.system(size: 40))
                            .foregroundStyle(.blue)
                    }

                Text(product.name)
                    .font(.headline)
                    .lineLimit(2)

                HStack {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.1f", product.rating))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Text("$\(String(format: "%.2f", product.price))")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .navigationTitle("Product Grid")
    }
}

// MARK: - Add to Cart Button Demo

struct AddToCartButtonDemo: View {
    @State private var isPrimaryAdded = false
    @State private var isSecondaryAdded = false
    @State private var isMinimalAdded = false

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack(alignment: .leading) {
                    Text("Primary Style")
                        .font(.headline)

                    AddToCartButton(isAdded: $isPrimaryAdded, style: .primary) {
                        try? await Task.sleep(for: .seconds(1))
                    }
                }

                VStack(alignment: .leading) {
                    Text("Secondary Style")
                        .font(.headline)

                    AddToCartButton(isAdded: $isSecondaryAdded, style: .secondary) {
                        try? await Task.sleep(for: .seconds(1))
                    }
                }

                VStack(alignment: .leading) {
                    Text("Minimal Style")
                        .font(.headline)

                    AddToCartButton(isAdded: $isMinimalAdded, style: .minimal) {
                        try? await Task.sleep(for: .seconds(1))
                    }
                }

                Button("Reset All") {
                    isPrimaryAdded = false
                    isSecondaryAdded = false
                    isMinimalAdded = false
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .navigationTitle("Add to Cart Button")
    }
}

// MARK: - Quantity Selector Demo

struct QuantitySelectorDemo: View {
    @State private var quantity1 = 1
    @State private var quantity2 = 3
    @State private var quantity3 = 5

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Rounded Style")
                        .font(.headline)

                    QuantitySelector(quantity: $quantity1, style: .rounded)

                    Text("Current quantity: \(quantity1)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Square Style")
                        .font(.headline)

                    QuantitySelector(quantity: $quantity2, style: .square)

                    Text("Current quantity: \(quantity2)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Minimal Style")
                        .font(.headline)

                    QuantitySelector(quantity: $quantity3, style: .minimal) { newQuantity in
                        print("Quantity changed to: \(newQuantity)")
                    }

                    Text("Current quantity: \(quantity3)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Quantity Selector")
    }
}

// MARK: - Price Tag Demo

struct PriceTagDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Standard Prices")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        PriceTag(price: 19.99, size: .small)
                        PriceTag(price: 49.99, size: .medium)
                        PriceTag(price: 99.99, size: .large)
                        PriceTag(price: 299.99, size: .extraLarge)
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Text("Discounted Prices")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        PriceTag(price: 79.99, originalPrice: 99.99)
                        PriceTag(price: 39.99, originalPrice: 59.99, size: .large)
                        PriceTag(price: 149.99, originalPrice: 199.99, size: .extraLarge)
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Text("Different Currencies")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        PriceTag(price: 99.99, currency: .usd)
                        PriceTag(price: 89.99, currency: .eur)
                        PriceTag(price: 79.99, currency: .gbp)
                        PriceTag(price: 10500, currency: .jpy, showCents: false)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Price Tag")
    }
}

// MARK: - Discount Badge Demo

struct DiscountBadgeDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack(alignment: .leading) {
                    Text("Product Card Example")
                        .font(.headline)

                    productCardExample
                }

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Text("Badge Sizes")
                        .font(.headline)

                    HStack(spacing: 12) {
                        DiscountBadge(discount: 50, style: .percentage, size: .small)
                        DiscountBadge(discount: 25, style: .percentage, size: .medium)
                        DiscountBadge(discount: 15, style: .percentage, size: .large)
                    }
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Badge Styles")
                        .font(.headline)

                    HStack(spacing: 12) {
                        DiscountBadge(text: "SALE", style: .sale, size: .medium)
                        DiscountBadge(text: "NEW", style: .new, size: .medium)
                        DiscountBadge(text: "HOT", style: .custom(color: .purple), size: .medium)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Discount Badge")
    }

    private var productCardExample: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.1))
                    .frame(height: 200)

                DiscountBadge(discount: 30)
                    .padding(12)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Wireless Headphones")
                    .font(.headline)

                HStack {
                    PriceTag(price: 69.99, originalPrice: 99.99)
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}

// MARK: - Size Selector Demo

struct SizeSelectorDemo: View {
    @State private var selectedSize1: String? = "M"
    @State private var selectedSize2: String?

    let clothingSizes = ["XS", "S", "M", "L", "XL", "XXL"]
    let shoeSizes = ["7", "8", "9", "10", "11", "12"]

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                VStack(alignment: .leading) {
                    Text("Clothing Sizes (Rounded)")
                        .font(.headline)

                    SizeSelector(
                        sizes: clothingSizes,
                        selectedSize: $selectedSize1,
                        unavailableSizes: ["XS", "XXL"],
                        style: .rounded
                    )

                    if let size = selectedSize1 {
                        Text("Selected: \(size)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                VStack(alignment: .leading) {
                    Text("Shoe Sizes (Square)")
                        .font(.headline)

                    SizeSelector(
                        sizes: shoeSizes,
                        selectedSize: $selectedSize2,
                        unavailableSizes: ["7", "12"],
                        style: .square
                    )

                    if let size = selectedSize2 {
                        Text("Selected: \(size)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Size Selector")
    }
}

// MARK: - Color Swatch Demo

struct ColorSwatchDemo: View {
    @State private var selectedColor1: UUID?
    @State private var selectedColor2: UUID?
    @State private var selectedColor3: UUID?

    let colors = [
        ColorOption(name: "Black", color: .black),
        ColorOption(name: "White", color: .white),
        ColorOption(name: "Blue", color: .blue),
        ColorOption(name: "Red", color: .red),
        ColorOption(name: "Green", color: .green),
        ColorOption(name: "Purple", color: .purple)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                VStack(alignment: .leading) {
                    Text("Circle Style (Small)")
                        .font(.headline)

                    ColorSwatch(
                        colors: colors,
                        selectedColor: $selectedColor1,
                        size: .small,
                        style: .circle
                    )
                }

                VStack(alignment: .leading) {
                    Text("Rounded Style (Medium)")
                        .font(.headline)

                    ColorSwatch(
                        colors: colors,
                        selectedColor: $selectedColor2,
                        size: .medium,
                        style: .rounded
                    )
                }

                VStack(alignment: .leading) {
                    Text("Square Style (Large)")
                        .font(.headline)

                    ColorSwatch(
                        colors: colors,
                        selectedColor: $selectedColor3,
                        size: .large,
                        style: .square
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Color Swatch")
    }
}

// MARK: - Checkout Progress Demo

struct CheckoutProgressDemo: View {
    @State private var currentStep = 1
    let steps = ["Cart", "Shipping", "Payment", "Review"]

    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Dots Style")
                        .font(.headline)

                    CheckoutProgress(
                        steps: steps,
                        currentStep: currentStep,
                        style: .dots
                    )
                }

                VStack(alignment: .leading, spacing: 20) {
                    Text("Numbers Style")
                        .font(.headline)

                    CheckoutProgress(
                        steps: steps,
                        currentStep: currentStep,
                        style: .numbers
                    )
                }

                VStack(alignment: .leading, spacing: 20) {
                    Text("Bar Style")
                        .font(.headline)

                    CheckoutProgress(
                        steps: steps,
                        currentStep: currentStep,
                        style: .bar
                    )
                }

                HStack {
                    Button("Previous") {
                        if currentStep > 0 {
                            currentStep -= 1
                        }
                    }
                    .disabled(currentStep == 0)

                    Spacer()

                    Button("Next") {
                        if currentStep < steps.count - 1 {
                            currentStep += 1
                        }
                    }
                    .disabled(currentStep == steps.count - 1)
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .navigationTitle("Checkout Progress")
    }
}

// MARK: - Order Status Demo

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

// MARK: - Supporting Models

struct ProductData: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let rating: Double
}

// MARK: - Previews

#Preview("Product Grid") {
    NavigationStack {
        ProductGridDemo()
    }
}

#Preview("Add to Cart") {
    NavigationStack {
        AddToCartButtonDemo()
    }
}

#Preview("Quantity Selector") {
    NavigationStack {
        QuantitySelectorDemo()
    }
}

#Preview("Price Tag") {
    NavigationStack {
        PriceTagDemo()
    }
}

#Preview("Discount Badge") {
    NavigationStack {
        DiscountBadgeDemo()
    }
}

#Preview("Size Selector") {
    NavigationStack {
        SizeSelectorDemo()
    }
}

#Preview("Color Swatch") {
    NavigationStack {
        ColorSwatchDemo()
    }
}

#Preview("Checkout Progress") {
    NavigationStack {
        CheckoutProgressDemo()
    }
}

#Preview("Order Status") {
    NavigationStack {
        OrderStatusDemo()
    }
}
