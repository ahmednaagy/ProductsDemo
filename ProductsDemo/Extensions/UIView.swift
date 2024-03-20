//
//  UIView.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 20/03/2024.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
}
