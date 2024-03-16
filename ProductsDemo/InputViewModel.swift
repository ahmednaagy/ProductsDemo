//
//  InputViewModel.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 16/03/2024.
//

import Foundation

class CustomInputViewModel {
    var validation: InputValidation?

    func validate(_ text: String?) -> String? {
        return validation?.validate(text)
    }
}




