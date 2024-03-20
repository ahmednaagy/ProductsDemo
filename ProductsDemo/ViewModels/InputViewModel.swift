//
//  InputViewModel.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 16/03/2024.
//

import UIKit

// MARK: - Model
struct InputFieldModel {
    var title: String
    var placeholder: String
    var text: String = ""
    var errorMessage: String = ""

    init(title: String, placeholder: String) {
        self.title = title
        self.placeholder = placeholder
    }
}

// MARK: - ViewModel
class CustomInputViewModel {

    var inputModel: InputFieldModel
    let validation: InputValidation
    let emptyFieldErrorMessage: String

    init(inputModel: InputFieldModel, validation: InputValidation, emptyFieldErrorMessage: String) {
        self.inputModel = inputModel
        self.validation = validation
        self.emptyFieldErrorMessage = emptyFieldErrorMessage
    }

    func validateAndHandleError() {
        let text = inputModel.text
        if text.isEmpty {
            inputModel.errorMessage = emptyFieldErrorMessage
        } else {
            inputModel.errorMessage = validation.validate(text) ?? ""
        }
    }
}




