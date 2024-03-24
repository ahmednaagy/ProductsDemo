//
//  TermsViewController.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 24/03/2024.
//

import UIKit

protocol TermsViewControllerDelegate: AnyObject {
    func termsViewControllerDidDismiss()
}

class TermsViewController: UIViewController {

    weak var delegate: TermsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.dismiss(animated: true) {
                self.delegate?.termsViewControllerDidDismiss()
            }
        }
    }


    @IBAction func AgreeButtonTapped(_ sender: UIButton) {
        delegate?.termsViewControllerDidDismiss()
    }
    
}
