//
//  PhotosCell.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 25/03/2024.
//

import UIKit

class PhotosCell: UICollectionViewCell {

    /// The UIImageView for displaying the photo.
    @IBOutlet weak var image: UIImageView!

    /// The UILabel for displaying the title of the photo.
    @IBOutlet weak var titleLabel: UILabel!

    /// The UIButton for closing or dismissing the photo.
    @IBOutlet weak var closeButton: UIButton!

    /// The UILabel for displaying the size information of the photo.
    @IBOutlet weak var imageSizeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
