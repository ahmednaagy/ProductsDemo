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
        addTerms()
        addTerms()
        addTerms()
        addTerms()
        addTerms()
        addTerms()

        addDocumentsView()

        addSubmitButton()
    }

    // MARK: - Helper Methods

    fileprivate func addInputView(with title: String, placeholder: String, validation: InputValidation, emptyFieldErrorMessage: String) {
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

    fileprivate func addTerms() {
        // Create and configure MoneyCalculatorView instances
        let TermsAndConditionsView = TermsAndConditionsView()
        TermsAndConditionsView.delegate = self
        parentStackView.addArrangedSubview(TermsAndConditionsView)
    }

    fileprivate func addSubmitButton() {
        submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.heightAnchor.constraint(equalToConstant: 44).isActive = true // Adjust height as needed
        parentStackView.addArrangedSubview(submitButton)
    }
    
    fileprivate func addDocumentsView() {
        let documentsView = DocumentsView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        documentsView.delegate = self
        parentStackView.addArrangedSubview(documentsView)
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

// MARK: - Terms and Conditions Delegate

extension ViewController: TermsAndConditionsViewDelegate {
    func termsAndConditionsViewDidTap(_ view: TermsAndConditionsView) {
        let termsViewController = TermsViewController()
        termsViewController.delegate = self
        present(termsViewController, animated: true)
    }
}

// MARK: - Terms and Conditions View Controller Delegate

extension ViewController: TermsViewControllerDelegate {
    func termsViewControllerDidDismiss() {
        print("Change Check Box")
    }
}

// MARK: - Image Picker Delegate Method
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         picker.dismiss(animated: true, completion: nil)

         // Handle selected photos
         if let selectedImage = info[.originalImage] as? UIImage {
             if let documentsView = parentStackView.subviews.compactMap({ $0 as? DocumentsView }).first {
                 documentsView.images.append(selectedImage)
                 documentsView.documentsCollectionView.reloadData()
             }
         }
     }
}

// MARK: - Handle the documents view delegate methods

extension ViewController: DocumentsViewDelegate {

    func didSelectPhotos(_ photos: [UIImage]) {
        // Handle the selected photos here
        // You can perform any additional logic with the selected photos
        print("Selected photos: \(photos)")

        // If the number of selected photos exceeds 4, hide the "Add More" view
        if photos.count > 4 {
            if let documentsView = parentStackView.subviews.compactMap({ $0 as? DocumentsView }).first {
                documentsView.addMoreView.isHidden = true
            }
        }
    }

    func didTapAddMore() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

}
