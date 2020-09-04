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
    private struct Constants {
        static let readMoreTitle: String = "Read More →"
    }

    @IBOutlet var imageContainerView: BorderedContainerView!
    @IBOutlet var reloadImageButton: UIButton!
    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var previewLabel: UILabel!
    @IBOutlet var titleContainerView: BorderedContainerView!
    @IBOutlet var previewContainerView: BorderedContainerView!
    @IBOutlet var readMoreLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageHeightConstraint: NSLayoutConstraint!

    private let nonReusableBag = DisposeBag()
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
        imageContainerView.layer.borderWidth = 0
        articleImageView.image = nil

        Constants.readMoreTitle.localized()
            .drive(readMoreLabel.rx.text)
            .disposed(by: nonReusableBag)
    }

    func configure(with feedItem: FeedItem) {
        guard let viewModel = feedItem as? ArticleItemViewModel else { return }

        viewModel.title
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.preview
            .drive(previewLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.imageDriver
            .drive(onNext: { [weak self] in
                self?.articleImageView.image = $0
                self?.updateImageViewHeight(with: viewModel.referenceImageRatio)
            })
            .disposed(by: disposeBag)

        viewModel.isLoadingDriver
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel.showImageLoadErrorState
            .drive(rx.updateErrorState())
            .disposed(by: disposeBag)

        reloadImageButton.rx.tap
            .subscribe(onNext: { [weak viewModel] in
                viewModel?.loadImage()
            })
            .disposed(by: disposeBag)

        viewModel.loadImage()
    }

    private func updateImageViewHeight(with ratio: CGFloat) {
        guard ratio != 0 else { return }
        let newHeight = articleImageView.bounds.width / ratio
        imageHeightConstraint.constant = newHeight
    }
}

fileprivate extension Reactive where Base: ArticleFeedCell {
    func updateErrorState() -> Binder<Bool> {
        return Binder(base) { cell, showImageLoadErrorState in
            if showImageLoadErrorState {
                cell.imageContainerView.layer.borderWidth = BorderedContainerView.Constants.defaultBorderWidth
                cell.reloadImageButton.isHidden = false
            } else {
                cell.imageContainerView.layer.borderWidth = 0
                cell.reloadImageButton.isHidden = true
            }
        }
    }
}
