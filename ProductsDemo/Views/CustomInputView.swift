//
//  CustomInputView.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 16/03/2024.
//

import UIKit

protocol InputValidation {
    func validate(_ text: String?) -> String?
}

class CustomInputView: UIView {


    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    // MARK: - Properties

    var validation: InputValidation?
    var emptyFieldErrorMessage: String?


    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)

        setupUI()
    }

    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "CustomInputView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    // MARK: - Public Methods

     func setTitle(_ title: String) {
         titleLabel.text = title
     }

     func setPlaceholder(_ placeholder: String) {
         textField.placeholder = placeholder
     }

     func setError(_ error: String?) {
         errorLabel.isHidden = error == nil
         errorLabel.text = error
         if let error = error {
             animateErrorView(toColor: UIColor.red, errorMessage: error)
         } else {
             resetErrorView(toColor: UIColor.gray)
         }
     }

     private func updateErrorLabel(_ errorMessage: String?) {
         setError(errorMessage)
     }

     func getText() -> String? {
         return textField.text
     }

     func validateAndHandleError() {
         let text = getText()
         if text?.isEmpty ?? true {
             setError(emptyFieldErrorMessage)
         } else {
             let errorMessage = validation?.validate(text)
             setError(errorMessage)
         }
     }

     private func setupUI() {
         textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
         textField.layer.cornerRadius = 8.0
         textField.layer.borderColor = UIColor.gray.cgColor
         textField.layer.borderWidth = 1
         textField.delegate = self
         errorLabel.alpha = 0.0
     }
 }


extension CustomInputView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateTextFieldBorderColor(toColor: UIColor(red: 111/255.0, green: 1/255.0, blue: 228/255.0, alpha: 1.0))
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        validateText(textField.text)
    }

    private func validateText(_ text: String?) {
        guard let validation = validation else {
            setError(nil)
            return
        }

        let errorMessage = validation.validate(text)
        errorLabel.isHidden = (errorMessage == nil)
        setError(errorMessage)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Hide keyboard when return key is pressed
        return true
    }
}
