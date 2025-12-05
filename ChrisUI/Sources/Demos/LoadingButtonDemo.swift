//
//  LoadingButtonDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

struct LoadingButtonDemo: View {
    @State private var viewModel = LoadingButtonViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                LoadingButton(
                    title: "Submit",
                    isLoading: $viewModel.isLoading1,
                    action: {
                        Task {
                            await viewModel.handleSubmit()
                        }
                    }
                )

                LoadingButton(
                    title: "Save Changes",
                    isLoading: $viewModel.isLoading2,
                    style: .outlined,
                    backgroundColor: .blue,
                    action: {
                        Task {
                            await viewModel.handleSave()
                        }
                    }
                )

                LoadingButton(
                    title: "Upload",
                    isLoading: $viewModel.isLoading3,
                    icon: "arrow.up.circle",
                    backgroundColor: .green,
                    action: {
                        Task {
                            await viewModel.handleUpload()
                        }
                    }
                )
            }
            .padding()
        }
        .navigationTitle("Loading Buttons")
        .navigationBarTitleDisplayMode(.inline)
    }
}
