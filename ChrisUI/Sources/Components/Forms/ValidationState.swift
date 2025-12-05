//
//  ValidationState.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/5/25.
//
import Foundation

public enum ValidationState {
    case idle
    case valid
    case invalid(String)

    var isValid: Bool {
        if case .valid = self { return true }
        return false
    }

    var errorMessage: String? {
        if case .invalid(let message) = self { return message }
        return nil
    }
}
