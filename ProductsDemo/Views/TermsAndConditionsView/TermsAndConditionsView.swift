//
//  TermsAndConditionsView.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 24/03/2024.
//

import UIKit

protocol TermsAndConditionsViewDelegate: AnyObject {
    func termsAndConditionsViewDidTap(_ view: TermsAndConditionsView)
}

class TermsAndConditionsView: UIView {


    @IBOutlet weak var termsAndConditionView: UIView!
    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var errorLabel: UILabel!

    weak var delegate: TermsAndConditionsViewDelegate?



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
        setupViews()
    }

    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "TermsAndConditionsView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    private func setupViews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        termsAndConditionView.addGestureRecognizer(tapGesture)
        errorLabel.alpha = 0
    }

    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        // Navigate to another view controller to display full terms and conditions

        /// let termsVC = TermsViewController()
        /// termsVC.delegate = delegate
        /// present(termsVC, animated: true, completion: nil)

        print("Tapped")

    }
    
}
