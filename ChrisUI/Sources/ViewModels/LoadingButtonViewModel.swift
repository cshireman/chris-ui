//
//  LoadingButtonViewModel.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import Combine
import Foundation

/// View model for managing loading button demo state
///
/// This observable class demonstrates multiple loading states for
/// the LoadingButton component with simulated async operations.
@Observable
class LoadingButtonViewModel {
    /// Loading state for the first button
    var isLoading1: Bool = false
    /// Loading state for the second button
    var isLoading2: Bool = false
    /// Loading state for the third button
    var isLoading3: Bool = false

    /// Handles submit action with simulated async operation
    func handleSubmit() async {
        isLoading1 = true

        // Simulate async operation
        try? await Task.sleep(for: .seconds(2))

        print("Submit completed")
        isLoading1 = false
    }

    /// Handles save action with simulated async operation
    func handleSave() async {
        isLoading2 = true

        // Simulate async operation
        try? await Task.sleep(for: .seconds(2))

        print("Save completed")
        isLoading2 = false
    }

    /// Handles upload action with simulated async operation
    func handleUpload() async {
        isLoading3 = true

        // Simulate async operation
        try? await Task.sleep(for: .seconds(2))

        print("Upload completed")
        isLoading3 = false
    }
}
