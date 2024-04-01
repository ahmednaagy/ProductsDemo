

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
    func didTapUploadPhoto()
}

class DocumentsView: UIView {


    @IBOutlet var contentView: UIView!
    @IBOutlet weak var uploadPhotoPlaceholderView: UIView!
    @IBOutlet weak var documentsCollectionView: UICollectionView!
    @IBOutlet weak var documentsParentView: UIStackView!
    @IBOutlet weak var addMoreView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var collectionViewTrailingConstraint: NSLayoutConstraint!


    weak var delegate: DocumentsViewDelegate?

    let cellWidth: CGFloat = 140 // Fixed width for each cell

    // Images array for storing selected photos
    var images: [UIImage] = [] {
        didSet {
            reloadCollectionView()
        }
    }

    var hasError: Bool {
        return !uploadPhotoPlaceholderView.isHidden
    }

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
        setupUploadPhotoPlaceholderView()

        // Hide documentsCollectionView and addMoreView initially
        documentsCollectionView.isHidden = true
        // Configure autoresizing mask
        documentsCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addMoreView.isHidden = true

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

    func showSelectedImages() {
        uploadPhotoPlaceholderView.isHidden = true
        documentsCollectionView.isHidden = false
        addMoreView.isHidden = false
    }

    func hideSelectedImages() {
        uploadPhotoPlaceholderView.isHidden = false
        documentsCollectionView.isHidden = true
        addMoreView.isHidden = true
    }

    private func setupUploadPhotoPlaceholderView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(uploadPhotoPlaceholderTapped))
        uploadPhotoPlaceholderView.addGestureRecognizer(tapGesture)
        uploadPhotoPlaceholderView.isUserInteractionEnabled = true
    }

    @objc private func uploadPhotoPlaceholderTapped() {
        delegate?.didTapUploadPhoto()
    }

    // Function to reload collection view and update its width
    func reloadCollectionView() {
        documentsCollectionView.reloadData()
        updateCollectionViewWidth() // Call this to update collection view width based on content
    }
}
// MARK: - UICollectionViewDataSource

extension DocumentsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! PhotosCell
        let image = images[indexPath.item]
        cell.image.image = image
        cell.titleLabel.text = "Title"
        cell.imageSizeLabel.text = "Size"
        cell.closeButton.tag = indexPath.item // Set tag to identify which image to delete
        cell.closeButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: collectionView.bounds.height)
    }

    // Update collection view width based on content size
    private func updateCollectionViewWidth() {
        // Calculate the total width required for all cells
        var totalCellWidth: CGFloat = 0
        for indexPath in documentsCollectionView.indexPathsForVisibleItems {
            let cellWidth = collectionView(documentsCollectionView, layout: documentsCollectionView.collectionViewLayout, sizeForItemAt: indexPath).width
            totalCellWidth += cellWidth
            print(totalCellWidth)
        }

        // Adjust for spacing between cells
        let spacingBetweenCells: CGFloat = 10
        var spaceToBePushed: CGFloat = 0


        /// Remaining space of the substraction of the collection view width from the cell width
        let hagaTanya = documentsCollectionView.bounds.size.width - CGFloat(images.count) * 140 // cells takes the whole space

        if hagaTanya < 0 {
            spaceToBePushed = 0
        } else {
            spaceToBePushed = documentsCollectionView.bounds.size.width - CGFloat(images.count) * 140
        }

        // Get the main screen bounds
        let screenSize = UIScreen.main.bounds

        // Extract width
        let screenWidth = screenSize.width

        if spaceToBePushed > screenWidth {
            return
        } else {
            collectionViewTrailingConstraint.constant = spaceToBePushed
        }
    }

    @objc private func deleteButtonTapped(_ sender: UIButton) {
        // Handle delete button tap
        let indexToRemove = sender.tag
        images.remove(at: indexToRemove)
        if images.isEmpty {
            hideSelectedImages()
        }
    }
}
