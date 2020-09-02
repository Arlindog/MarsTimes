//
//  ArticleFeedCell.swift
//  MarsTimes
//
//  Created by Arlindo on 8/31/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import RxSwift
import RxCocoa

class ArticleFeedCell: UITableViewCell, FeedCell {
    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var previewLabel: UILabel!
    @IBOutlet var titleContainerView: UIView!
    @IBOutlet var previewContainerView: UIView!
    @IBOutlet var readMoreLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    private var imageHeightConstraint: NSLayoutConstraint?
    private var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
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

        viewModel.imageDriver
            .drive(onNext: { [weak self] image in
                self?.articleImageView.image = image
                self?.updateImageViewHeight(with: image)
            })
            .disposed(by: disposeBag)

        viewModel.isLoadingDriver
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }

    private func updateImageViewHeight(with image: UIImage?) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height
        let newHeight = articleImageView.frame.width / ratio

        if let imageHeightConstraint = imageHeightConstraint {
            imageHeightConstraint.constant = newHeight
        } else {
            imageHeightConstraint = articleImageView.heightAnchor.constraint(equalToConstant: newHeight)
            imageHeightConstraint?.priority = .defaultHigh
            imageHeightConstraint?.isActive = true
        }

        layoutIfNeeded()
    }
}
