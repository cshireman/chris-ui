//
//  EcommerceModels.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import Foundation

/// A simple product data model for e-commerce demonstrations
struct ProductData: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let rating: Double
}
