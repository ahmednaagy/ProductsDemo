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

        // Example 1:
        let customInputView1 = CustomInputView()
        customInputView1.title = "Username"
        parentStackView.addArrangedSubview(customInputView1)

        // Example 2:
        let customInputView2 = CustomInputView()
        customInputView2.title = "Password"
        parentStackView.addArrangedSubview(customInputView2)
    }
}

