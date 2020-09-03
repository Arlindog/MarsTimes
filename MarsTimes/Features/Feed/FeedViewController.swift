//
//  FeedViewController.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import RxSwift
import RxCocoa

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var feedTableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    private let disposeBag = DisposeBag()
    private let viewModel = FeedViewModel()
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.loadFeed()
    }

    private func setup() {
        setupBindings()
        setupTableView()
        setupNavigationBar()
    }

    private func setupBindings() {
        viewModel.reloadFeedDriver
            .drive(onNext: { [weak self] in
                self?.feedTableView.reloadData()
            })
            .disposed(by: disposeBag)

        viewModel.isLoadingFeedDriver
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel.isLoadingFeedDriver
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)

        viewModel.openFeedItemSignal
            .emit(onNext: { [weak self] in
                self?.presentFeedItem(with: $0)
            })
            .disposed(by: disposeBag)

        viewModel.reloadFeedHeight
            .emit(onNext: { [weak self] in
                self?.feedTableView.performBatchUpdates({})
            })
            .disposed(by: disposeBag)
    }

    private func setupNavigationBar() {
        let settingsItem = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(openSettings))
        "Settings".localized()
            .drive(settingsItem.rx.title)
            .disposed(by: disposeBag)

        navigationItem.rightBarButtonItem = settingsItem

        let backBarButton = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(navigationController?.popViewController(animated:)))
        navigationItem.backBarButtonItem = backBarButton
        "Back".localized()
            .drive(backBarButton.rx.title)
            .disposed(by: disposeBag)
    }

    private func setupTableView() {
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(UINib(nibName: ArticleFeedCell.identifier, bundle: nil),
                               forCellReuseIdentifier: ArticleFeedCell.identifier)

        feedTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
    }

    @objc private func refreshFeed() {
        viewModel.loadFeed(type: .refresh)
    }

    @objc private func openSettings() {
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }

    private func presentFeedItem(with feedItemType: FeedItemType) {
        switch feedItemType {
        case .article(let itemViewModel):
            let articleDetailViewController = ArticleDetailViewController()
            articleDetailViewController.viewModel = itemViewModel
            navigationController?.pushViewController(articleDetailViewController, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.feedItemCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let feedItem = viewModel.getFeedItem(at: indexPath) else {
            fatalError("Expecting a feedItem at index path: \(indexPath)")
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: feedItem.cellIdentifier, for: indexPath)

        if let cell = cell as? FeedCell {
            cell.configure(with: feedItem)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectFeedItem(at: indexPath)
    }
}
