//
//  LoginScreenDemo.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//

import SwiftUI

struct LoginScreenDemo: View {
    @State private var viewModel = LoginViewModel()

    var body: some View {
        LoginScreen(viewModel)
            .navigationTitle("Login Screen")
            .navigationBarTitleDisplayMode(.inline)
    }
}
