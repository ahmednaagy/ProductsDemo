//
//  ProductsContactsView.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 01/04/2024.
//

import UIKit
import ContactsUI
import Contacts

protocol ContactPickerViewDelegate: AnyObject {
    func contactPickerViewDidTapContactsButton(_ contactPickerView: ProductsContactsView)
    func contactPickerView(_ contactPickerView: ProductsContactsView, didSelectContact phoneNumber: String)
}

class ProductsContactsView: UIView {

    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var contactsView: UIView!
    @IBOutlet weak var phoneNumberErrorLabel: UILabel!

    // MARK: - Properties
    var validation: InputValidation?
    var emptyFieldErrorMessage: String?
    let contactsPicker = CNContactPickerViewController()

    weak var delegate: ContactPickerViewDelegate?

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
        let nib = UINib(nibName: "ProductsContactsView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    private func setupUI() {
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        phoneNumberTextField.inputAccessoryView = createToolbar()
        phoneNumberTextField.layer.borderColor = UIColor.gray.cgColor
        phoneNumberTextField.layer.borderWidth = 1
        phoneNumberTextField.delegate = self
        phoneNumberErrorLabel.alpha = 0.0

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openContacts))
        contactsView.addGestureRecognizer(tapGesture)

        // Contacts Picker Setup
        contactsPicker.delegate = self
    }

    func setError(_ error: String?) {
        phoneNumberErrorLabel.isHidden = error == nil
        phoneNumberErrorLabel.text = error
        if let error = error {
            animateErrorView(toColor: UIColor.red, errorMessage: error)
        } else {
            resetErrorView(toColor: UIColor.gray)
        }
    }

    // MARK: - Public Methods

     func setTitle(_ title: String) {
         titleLabel.text = title
     }

     func setPlaceholder(_ placeholder: String) {
         phoneNumberTextField.placeholder = placeholder
     }

     private func updateErrorLabel(_ errorMessage: String?) {
         setError(errorMessage)
     }

     func getText() -> String? {
         return phoneNumberTextField.text
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

    @objc private func openContacts() {
        delegate?.contactPickerViewDidTapContactsButton(self)
    }
}

// MARK: - UITextFieldDelegate
extension ProductsContactsView: UITextFieldDelegate {
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
        phoneNumberErrorLabel.isHidden = (errorMessage == nil)
        setError(errorMessage)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Hide keyboard when return key is pressed
        return true
    }
}

extension ProductsContactsView: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
        phoneNumberTextField.text = phoneNumber
        validateText(phoneNumber)
        delegate?.contactPickerView(self, didSelectContact: phoneNumber)
    }
}
