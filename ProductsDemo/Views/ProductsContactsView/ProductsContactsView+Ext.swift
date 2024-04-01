//
//  ProductsContactsView+Ext.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 01/04/2024.
//

import UIKit

extension ProductsContactsView {

    func animateErrorView(toColor color: UIColor, errorMessage: String) {
        let borderColorAnimation = CABasicAnimation(keyPath: "borderColor")
        borderColorAnimation.fromValue = UIColor.gray.cgColor
        borderColorAnimation.toValue = color.cgColor
        borderColorAnimation.duration = 0.45
        phoneNumberTextField.layer.borderColor = color.cgColor

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [borderColorAnimation]
        animationGroup.duration = 0.45
        phoneNumberTextField.layer.add(animationGroup, forKey: "errorAnimation")

        phoneNumberErrorLabel.isHidden = false
        phoneNumberErrorLabel.alpha = 0.0
        UIView.animate(withDuration: 0.45) {
            self.phoneNumberErrorLabel.alpha = 1.0
        }
    }

    func resetErrorView(toColor color: UIColor) {
        UIView.animate(withDuration: 0.45) {
            self.phoneNumberErrorLabel.alpha = 0.0
        }
    }

    func animateTextFieldBorderColor(toColor color: UIColor) {
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = phoneNumberTextField.layer.borderColor
        animation.toValue = color.cgColor
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        phoneNumberTextField.layer.add(animation, forKey: "borderColor")

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        phoneNumberTextField.layer.borderColor = color.cgColor
        CATransaction.commit()
    }

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
        phoneNumberTextField.resignFirstResponder()
    }
}
