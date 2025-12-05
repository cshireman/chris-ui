//
//  LoginScreenDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demo view showcasing the LoginScreen component
///
/// This demo presents the LoginScreen component in a navigation context,
/// allowing users to interact with the login interface and observe its behavior.
struct LoginScreenDemo: View {
    @State private var viewModel = LoginViewModel()

    var body: some View {
        LoginScreen(viewModel)
            .navigationTitle("Login Screen")
            .navigationBarTitleDisplayMode(.inline)
    }
}
