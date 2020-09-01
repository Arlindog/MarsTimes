//
//  ArticleDetailViewController.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var titleContainerView: UIView!
    @IBOutlet var imageHeightConstraint: NSLayoutConstraint!

    var viewModel: ArticleItemViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupViewModel()
        setupViews()
    }

    private func setupViewModel() {
        articleImageView.image = viewModel.image
        updateImageViewHeight(with: viewModel.image)

        titleLabel.text = viewModel.title
        bodyLabel.text = viewModel.body
    }

    private func setupViews() {
        titleContainerView.layer.borderWidth = 3
        titleContainerView.layer.borderColor = UIColor.lightGray.cgColor

        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        bodyLabel.font = .preferredFont(forTextStyle: .body)
    }

    private func updateImageViewHeight(with image: UIImage?) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height
        let newHeight = articleImageView.frame.width / ratio
        imageHeightConstraint.constant = newHeight
        view.layoutIfNeeded()
    }
}
