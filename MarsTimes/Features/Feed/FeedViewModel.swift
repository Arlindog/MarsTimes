//
//  FeedViewModel.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

class FeedViewModel {
    private let feedService: FeedService
    private var feedItem: [FeedItem] = []

    var reloadFeed: (() -> Void)? = nil
    var isLoadingFeed: ((Bool) -> Void)? = nil

    var feedItemCount: Int {
        return feedItem.count
    }

    init(feedService: FeedService = .shared) {
        self.feedService = feedService
    }

    func loadFeed(type: RequestType = .standard) {
        switch type {
        case .standard:
            isLoadingFeed?(true)
        default:
            break
        }
        feedService.fetchFeed { [weak self] result in
            self?.isLoadingFeed?(false)
            switch result {
            case .success(let articles):
                self?.feedItem = articles.map {
                    ArticleItemViewModel(article: $0)
                }
                self?.reloadFeed?()
            case .failure(let error):
                print("Error loading feed: \(error)")
            }
        }
    }

    func getFeedItem(at indexPath: IndexPath) -> FeedItem? {
        guard
            indexPath.section == 0,
            indexPath.item >= 0 && indexPath.item < feedItemCount
            else { return nil }
        return feedItem[indexPath.item]
    }

    func didSelectFeedItem(at indexPath: IndexPath) {
        guard let feedItem = getFeedItem(at: indexPath) else { return }
        // TODO: Present feed item
    }
}
