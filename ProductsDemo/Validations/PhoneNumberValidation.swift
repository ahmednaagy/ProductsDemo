//
//  PhoneNumberValidation.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 16/03/2024.
//

import Foundation

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
