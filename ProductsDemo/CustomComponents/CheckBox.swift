//
//  CheckBox.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 24/03/2024.
//

import UIKit

/// A custom checkbox button that allows users to toggle between checked and unchecked states.
public class CheckBox: UIButton {

    /// The image to be displayed when the checkbox is checked.
    let checkedImage = UIImage(resource: .checkRebranding)

    /// The image to be displayed when the checkbox is unchecked.
    let uncheckedImage = UIImage(resource: .uncheck)

    /// A boolean value indicating whether the checkbox is in the checked state.
    public var isChecked: Bool = true {
        didSet {
            if isChecked {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }

    /// This method is called when the checkbox is loaded from a storyboard or Nib file.
    public override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
        self.setTitle(self.titleLabel?.text, for: .normal)
    }

    /// Handles the button click event to toggle the checkbox state.
    /// - Parameter sender: The button that was clicked.
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            if isChecked {
                isChecked = false
            } else {
                isChecked = true
            }
        }
    }
}
