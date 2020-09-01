//
//  ArticleFeedCell.swift
//  MarsTimes
//
//  Created by Arlindo on 8/31/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import UIKit

class ArticleFeedCell: UITableViewCell, FeedCell {
    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var previewLabel: UILabel!
    @IBOutlet var titleContainerView: UIView!
    @IBOutlet var previewContainerView: UIView!
    @IBOutlet weak var readMoreLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    private var imageHeightConstraint: NSLayoutConstraint?

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        titleContainerView.layer.borderWidth = 3
        titleContainerView.layer.borderColor = UIColor.lightGray.cgColor
        previewContainerView.layer.borderWidth = 3
        previewContainerView.layer.borderColor = UIColor.lightGray.cgColor

        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        previewLabel.font = .preferredFont(forTextStyle: .body)
        readMoreLabel.font = .preferredFont(forTextStyle: .footnote)
    }

    func configure(with feedItem: FeedItem) {
        guard let viewModel = feedItem as? ArticleItemViewModel else { return }
        titleLabel.text = viewModel.title
        previewLabel.text = viewModel.preview
        viewModel.imageUpdater = { [weak self] image in
            DispatchQueue.main.async { [weak self] in
                self?.articleImageView.image = image
                self?.updateImageViewHeight(with: image)
            }
        }

        viewModel.isLoadingImage = { [weak self] isLoading in
            DispatchQueue.main.async { [weak self] in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }

    private func updateImageViewHeight(with image: UIImage?) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height
        let newHeight = articleImageView.frame.width / ratio

        if let imageHeightConstraint = imageHeightConstraint {
            imageHeightConstraint.constant = newHeight
        } else {
            imageHeightConstraint = articleImageView.heightAnchor.constraint(equalToConstant: newHeight)
            imageHeightConstraint?.isActive = true
        }

        layoutIfNeeded()
    }
}
