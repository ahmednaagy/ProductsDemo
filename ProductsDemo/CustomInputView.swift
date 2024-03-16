//
//  CustomInputView.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 16/03/2024.
//

import UIKit

class CustomInputView: UIView {


    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    // MARK: - Properties

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
        }
    }

    var validationRule: ((String?) -> String?)?


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
        
        setupTextField()
    }

    // MARK: - Public Methods

     func setTitle(_ title: String) {
         titleLabel.text = title
     }

     func setText(_ text: String) {
         textField.text = text
     }

     func setError(_ error: String?) {
         errorLabel.text = error
         errorLabel.isHidden = error == nil
     }

     func getText() -> String? {
         return textField.text
     }


    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "CustomInputView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }


    private func setupTextField() {
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }

    // MARK: - Text Field Validation

    @objc private func textFieldEditingChanged(_ sender: UITextField) {
        validateText(sender.text)
    }

    private func validateText(_ text: String?) {
        // Perform your validation logic here
        if let text = text, text.isEmpty {
            setError("Field cannot be empty")
        } else {
            setError(nil)
        }
    }
}
