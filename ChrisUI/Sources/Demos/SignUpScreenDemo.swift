//
//  SignUpScreenDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

struct SignUpScreenDemo: View {
    @State private var viewModel = SignUpViewModel()

    var body: some View {
        SignUpScreen(viewModel)
        .navigationTitle("Sign Up Screen")
        .navigationBarTitleDisplayMode(.inline)
    }
}
