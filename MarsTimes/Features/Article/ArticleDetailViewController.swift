//
//  ArticleDetailViewController.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import RxSwift
import RxCocoa

class ArticleDetailViewController: UIViewController {

    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var titleContainerView: UIView!
    @IBOutlet var imageHeightConstraint: NSLayoutConstraint!

    private let disposeBag = DisposeBag()
    var viewModel: ArticleItemViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let image = articleImageView.image else { return }
        let ratio = image.size.width / image.size.height
        let newHeight = articleImageView.frame.width / ratio
        imageHeightConstraint.constant = newHeight
    }

    private func setup() {
        setupBindings()
        setupViews()
        setupNavigationBar()
    }

    private func setupBindings() {
        titleLabel.text = viewModel.title
        bodyLabel.text = viewModel.body

        viewModel.imageDriver
            .drive(articleImageView.rx.image)
            .disposed(by: disposeBag)
    }

    private func setupViews() {
        titleContainerView.layer.borderWidth = 3
        titleContainerView.layer.borderColor = UIColor.lightGray.cgColor

        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        bodyLabel.font = .preferredFont(forTextStyle: .body)
    }

    private func setupNavigationBar() {
        let settingsItem = UIBarButtonItem(title: "Settings", style: .done, target: self, action: #selector(openSettings))
        navigationItem.rightBarButtonItem = settingsItem
    }

    @objc private func openSettings() {
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
