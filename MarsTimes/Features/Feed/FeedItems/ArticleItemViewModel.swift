//
//  ArticleItemViewModel.swift
//  MarsTimes
//
//  Created by Arlindo on 8/31/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import UIKit

class ArticleItemViewModel: ImageFeedItem {
    let cellIdentifier = ArticleFeedCell.identifier

    private let article: Article
    private let imageService: ImageServicing

    var title: String {
        return article.title
    }

    var preview: String {
        return "\(article.body.split(separator: " ").prefix(11).joined(separator: " "))..."
    }

    var body: String {
        return article.body
    }

    var imageUpdater: ((UIImage?) -> Void)? = nil
    var isLoadingImage: ((Bool) -> Void)? = nil

    init(article: Article,
         imageService: ImageServicing = ImageService.shared) {
        self.article = article
        self.imageService = imageService
    }

    func loadImage() {
        guard let topImageInfo = article.topImageInfo else { return }
        isLoadingImage?(true)
        imageService.loadImage(url: topImageInfo.url) { [weak self] (image) in
            self?.isLoadingImage?(false)
            self?.imageUpdater?(image)
        }
    }
}
