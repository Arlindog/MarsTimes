//
//  FeedViewModel.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

class FeedViewModel {
    let feedService: FeedService

    init(feedService: FeedService = .shared) {
        self.feedService = feedService
    }

    func loadFeed() {
        feedService.fetchFeed { result in
            switch result {
            case .success(let articles):
                print(articles.count)
            case .failure(let error):
                print("Error loading feed: \(error)")
            }
        }
    }
}
