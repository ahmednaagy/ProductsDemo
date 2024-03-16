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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let phoneNumberInputView = CustomInputView()
        phoneNumberInputView.title = "Please enter Phone number"
        phoneNumberInputView.placeholder = "Enter Phone number"
        phoneNumberInputView.validation = PhoneNumberValidation()
        parentStackView.addArrangedSubview(phoneNumberInputView)

    }
}

