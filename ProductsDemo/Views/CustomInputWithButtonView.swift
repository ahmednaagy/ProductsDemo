//
//  CustomInputWithButtonView.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 20/03/2024.
//

import UIKit

protocol MoneyCalculatorViewDelegate: AnyObject {
    func calculateButtonTapped()
}

class CustomInputWithButtonView: UIView {

    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    // Properties
    var validation: InputValidation?
    weak var delegate: MoneyCalculatorViewDelegate?

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
        setupButton()

    }

    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "CustomInputWithButtonView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    private func setupTextField() {
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        textField.inputAccessoryView = createToolbar()
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.delegate = self
        errorLabel.alpha = 0.0
    }

    private func setupButton() {
        actionButton.isEnabled = false
    }

    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        // Enable the button if the text field has at least two characters
        actionButton.isEnabled = (textField.text?.count ?? 0) >= 2
    }

    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        delegate?.calculateButtonTapped()
    }

    func setError(_ error: String?) {
        if let error = error {
            animateErrorView()
            animateTextFieldBorderColor(toColor: UIColor.red)
            errorLabel.text = error
        } else {
            resetErrorView()
            animateTextFieldBorderColor(toColor: UIColor.gray)
        }
    }

    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)

        return toolbar
    }

    @objc private func doneButtonTapped() {
        textField.resignFirstResponder()
    }

    // MARK: - Animation

    private func animateTextFieldBorderColor(toColor color: UIColor) {
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = textField.layer.borderColor
        animation.toValue = color
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        textField.layer.add(animation, forKey: "borderColor")

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        textField.layer.borderColor = color.cgColor
        CATransaction.commit()
    }

    private func animateErrorView() {
        // Animate text field border color change
        let borderColorAnimation = CABasicAnimation(keyPath: "borderColor")
        borderColorAnimation.fromValue = UIColor.gray.cgColor
        borderColorAnimation.toValue = UIColor.red.cgColor
        borderColorAnimation.duration = 0.45
        textField.layer.borderColor = UIColor.red.cgColor

        // Combine animations
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [borderColorAnimation]
        animationGroup.duration = 0.45
        textField.layer.add(animationGroup, forKey: "errorAnimation")

        // Animate error label appearance
        errorLabel.isHidden = false
        errorLabel.alpha = 0.0
        UIView.animate(withDuration: 0.45) {
            self.errorLabel.alpha = 1.0
        }
    }

    private func resetErrorView() {
        // Hide error label
        UIView.animate(withDuration: 0.45) {
            self.errorLabel.alpha = 0.0
        }
    }
}

extension CustomInputWithButtonView: UITextFieldDelegate {

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

