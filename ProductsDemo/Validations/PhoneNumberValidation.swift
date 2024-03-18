//
//  PhoneNumberValidation.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 16/03/2024.
//

import Foundation


extension String {
    func validate(text: Self) {
        
    }
}

struct PhoneNumberValidation: InputValidation {
    func validate(_ text: String?) -> String? {
        guard let phoneNumber = text, !phoneNumber.isEmpty else {
            return "Phone number cannot be empty"
        }
        // You can add more complex validation rules here
        // For example, check if the phone number has a valid format
        return nil // No error message if validation passes
    }
}

// Example input validations
struct UsernameValidation: InputValidation {
    func validate(_ text: String?) -> String? {
        guard let text = text else { return "Username is required" }
        return text.count >= 6 ? nil : "Username should be at least 6 characters long"
    }
}

struct PasswordValidation: InputValidation {
    func validate(_ text: String?) -> String? {
        guard let text = text else { return "Password is required" }
        return text.count >= 8 ? nil : "Password should be at least 8 characters long"
    }
}

struct NationalIDValidation: InputValidation {
    func validate(_ text: String?) -> String? {
        guard let text = text else { return "Password is required" }
        return text.count >= 8 ? nil : "Password should be at least 8 characters long"
    }
}
