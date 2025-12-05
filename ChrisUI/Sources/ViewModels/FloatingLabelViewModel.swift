//
//  FloatingLabelViewModel.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import Combine
import Foundation

@Observable
class FloatingLabelViewModel {
    var email: String = ""
    var password: String = ""
    var name: String = ""

    var emailValidation: ValidationState {
        if email.isEmpty {
            return .idle
        }
        return email.isValidEmail ? .valid : .invalid("Invalid email format")
    }

    var nameValidation: ValidationState {
        if name.isEmpty {
            return .idle
        }
        return name.count >= 2 ? .valid : .invalid("Name must be at least 2 characters")
    }

    func submit() {
        print("Floating label form submitted: \(name), \(email)")
    }
}
