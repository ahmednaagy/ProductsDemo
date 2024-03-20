//
//  CustomInputWithButtonView+Extension.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 20/03/2024.
//

import UIKit

// MARK: - Animation Extension
extension CustomInputWithButtonView {

    func animateTextFieldBorderColor(toColor color: UIColor) {
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

    func animateErrorView() {
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

    func resetErrorView() {
        // Hide error label
        UIView.animate(withDuration: 0.45) {
            self.errorLabel.alpha = 0.0
        }
    }
}

// MARK: - Private Utility Methods Extension
extension CustomInputWithButtonView {
    func createToolbar() -> UIToolbar {
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
}
