//
//  CustomInputView.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 20/03/2024.
//

import UIKit

// MARK: - Animation Extension

extension CustomInputView {

    func animateErrorView(toColor color: UIColor, errorMessage: String) {
        let borderColorAnimation = CABasicAnimation(keyPath: "borderColor")
        borderColorAnimation.fromValue = UIColor.gray.cgColor
        borderColorAnimation.toValue = color.cgColor
        borderColorAnimation.duration = 0.45
        textField.layer.borderColor = color.cgColor

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [borderColorAnimation]
        animationGroup.duration = 0.45
        textField.layer.add(animationGroup, forKey: "errorAnimation")

        errorLabel.isHidden = false
        errorLabel.alpha = 0.0
        UIView.animate(withDuration: 0.45) {
            self.errorLabel.alpha = 1.0
        }
    }

    func resetErrorView(toColor color: UIColor) {
        UIView.animate(withDuration: 0.45) {
            self.errorLabel.alpha = 0.0
        }
    }

    func animateTextFieldBorderColor(toColor color: UIColor) {
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = textField.layer.borderColor
        animation.toValue = color.cgColor
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        textField.layer.add(animation, forKey: "borderColor")

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        textField.layer.borderColor = color.cgColor
        CATransaction.commit()
    }
}
