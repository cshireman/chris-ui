//
//  SignUpScreenDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

/// Demo view showcasing the SignUpScreen component
///
/// This demo presents the SignUpScreen component with full validation,
/// demonstrating password matching, terms acceptance, and form validation.
struct SignUpScreenDemo: View {
    @State private var viewModel = SignUpViewModel()

    var body: some View {
        SignUpScreen(viewModel)
            .navigationTitle("Sign Up Screen")
            .navigationBarTitleDisplayMode(.inline)
    }
}
