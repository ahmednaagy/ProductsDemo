

//
//  DocumentsView.swift
//  ProductsDemo
//
//  Created by Ahmed Nagy on 25/03/2024.
//

import UIKit

protocol DocumentsViewDelegate: AnyObject {
    func didTapAddMore()
    func didSelectPhotos(_ photos: [UIImage])
}

class DocumentsView: UIView, UICollectionViewDelegate {


    @IBOutlet var contentView: UIView!
    @IBOutlet weak var uploadPhotoPlaceholderView: UIView!
    @IBOutlet weak var documentsCollectionView: UICollectionView!
    @IBOutlet weak var addMoreView: UIView!
    @IBOutlet weak var errorLabel: UILabel!


    weak var delegate: DocumentsViewDelegate?

    // Images array for storing selected photos
    var images: [UIImage] = []


    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("DocumentsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        setupUI()
    }

    private func setupUI() {
        setupCollectionView()
        setupAddMoreView()

        // Hide error label initially
        errorLabel.isHidden = true
    }

    func setupCollectionView() {
        // Setup collection view appearance and behavior
        documentsCollectionView.delegate = self
        documentsCollectionView.dataSource = self
        // Register custom cell class
        documentsCollectionView.register(UINib(nibName: "PhotosCell", bundle: nil), forCellWithReuseIdentifier: "PhotosCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 140, height: 60)
        documentsCollectionView.collectionViewLayout = layout
    }

    private func setupAddMoreView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addMoreTapped))
        addMoreView.addGestureRecognizer(tapGesture)
    }

    // MARK: - Actions

    @objc private func addMoreTapped() {
        delegate?.didTapAddMore()
    }


}

// MARK: - UICollectionViewDataSource

extension DocumentsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! PhotosCell
        let image = images[indexPath.item]
        cell.image.image = image
        cell.titleLabel.text = "Title"
        cell.imageSizeLabel.text = "Size"
        cell.closeButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        return cell
    }

    @objc private func deleteButtonTapped(_ sender: UIButton) {
        // Handle delete button tap
        guard let cell = sender.superview?.superview as? UICollectionViewCell else {
            return
        }
        if let indexPath = documentsCollectionView.indexPath(for: cell) {
            images.remove(at: indexPath.item)
            documentsCollectionView.reloadData()
        }
    }
}
