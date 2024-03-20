//
//  ViewController.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 15/03/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var parentStackView: UIStackView!

    var inputViews: [CustomInputView] = []
    var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomInputWithButtonView()
        addInputView(with: "Username", placeholder: "Enter username", validation: UsernameValidation(), emptyFieldErrorMessage: "Username is required")
        addInputView(with: "Password", placeholder: "Enter password", validation: PasswordValidation(), emptyFieldErrorMessage: "Password is required")
        addInputView(with: "National ID", placeholder: "Enter National ID", validation: PasswordValidation(), emptyFieldErrorMessage: "National ID is required")
        addInputView(with: "Email", placeholder: "Enter Email", validation: PasswordValidation(), emptyFieldErrorMessage: "Email is required")

        addSubmitButton()
    }

    // MARK: - Helper Methods

    func addInputView(with title: String, placeholder: String, validation: InputValidation, emptyFieldErrorMessage: String) {
        let inputView = CustomInputView()
        inputView.setTitle(title)
        inputView.setPlaceholder(placeholder)
        inputView.validation = validation
        inputView.emptyFieldErrorMessage = emptyFieldErrorMessage
        parentStackView.addArrangedSubview(inputView)
        inputViews.append(inputView)
    }

    fileprivate func addCustomInputWithButtonView() {
        // Create and configure MoneyCalculatorView instances
        let firstMoneyCalculatorView = CustomInputWithButtonView()
        firstMoneyCalculatorView.delegate = self
        firstMoneyCalculatorView.validation = PasswordValidation()
        parentStackView.addArrangedSubview(firstMoneyCalculatorView)
    }

    func addSubmitButton() {
        submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchUpInside)
        // Add constraints to the submit button
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.heightAnchor.constraint(equalToConstant: 44).isActive = true // Adjust height as needed
        parentStackView.addArrangedSubview(submitButton)
    }


    // MARK: - Actions

    @objc func submitButtonTapped(_ sender: UIButton) {
        guard validateInputs() else {
            // Handle validation errors
            return
        }
        // Proceed with submit action
        performSubmitAction()
    }


    // MARK: - Validation

    func validateInputs() -> Bool {
        var isValid = true
        for inputView in inputViews {
            inputView.validateAndHandleError()
            if let errorMessage = inputView.errorLabel.text, !errorMessage.isEmpty {
                isValid = false
            }
        }
        return isValid
    }

    // MARK: - Submit Action

    func performSubmitAction() {
        print("Form submitted successfully")
    }

}

// MARK: - Action Button Delegate

extension ViewController: MoneyCalculatorViewDelegate {
    func calculateButtonTapped() {
        print("Button Tapped")
    }
}
