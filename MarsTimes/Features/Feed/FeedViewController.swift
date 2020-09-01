//
//  FeedViewController.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var feedTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private let viewModel = FeedViewModel()
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadFeed()
    }

    private func setup() {
        setupViewModel()
        setupTableView()
        setupNavigationBar()
    }

    private func setupViewModel() {
        viewModel.reloadFeed = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.feedTableView.reloadData()
            }
        }

        viewModel.isLoadingFeed = { [weak self] isLoading in
            DispatchQueue.main.async { [weak self] in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }

    private func setupNavigationBar() {
        
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

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let feedItem = viewModel.getFeedItem(at: indexPath) as? ImageFeedItem else { return }
        feedItem.loadImage()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectFeedItem(at: indexPath)
    }
}
