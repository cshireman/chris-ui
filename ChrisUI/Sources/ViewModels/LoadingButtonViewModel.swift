//
//  LoadingButtonViewModel.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import Combine
import Foundation

@Observable
class LoadingButtonViewModel {
    var isLoading1: Bool = false
    var isLoading2: Bool = false
    var isLoading3: Bool = false

    func handleSubmit() async {
        isLoading1 = true

        // Simulate async operation
        try? await Task.sleep(nanoseconds: 2_000_000_000)

        print("Submit completed")
        isLoading1 = false
    }

    func handleSave() async {
        isLoading2 = true

        // Simulate async operation
        try? await Task.sleep(nanoseconds: 2_000_000_000)

        print("Save completed")
        isLoading2 = false
    }

    func handleUpload() async {
        isLoading3 = true

        // Simulate async operation
        try? await Task.sleep(nanoseconds: 2_000_000_000)

        print("Upload completed")
        isLoading3 = false
    }
}
