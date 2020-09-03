//
//  ArticleItemViewModel.swift
//  MarsTimes
//
//  Created by Arlindo on 8/31/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import RxSwift
import RxCocoa

class ArticleItemViewModel: ImageFeedItem {
    let cellIdentifier = ArticleFeedCell.identifier

    private let article: Article
    private let imageService: ImageServicing
    private let imageRelay = BehaviorRelay<UIImage?>(value: nil)
    private let requestState = BehaviorRelay<RequestState>(value: .idle)

    var title: Driver<String> {
        return article.title.localized()
    }

    var preview: Driver<String> {
        return "\(article.body.split(separator: " ").prefix(11).joined(separator: " "))…".localized()
    }

    var body: Driver<String> {
        return article.body.localized()
    }

    var imageDriver: Driver<UIImage?> {
        return imageRelay.asDriver()
    }

    var image: UIImage? {
        return imageRelay.value
    }

    var isLoadingDriver: Driver<Bool> {
        return requestState.asDriver()
            .map { $0 == .loading }
    }

    init(article: Article,
         imageService: ImageServicing = ImageService.shared) {
        self.article = article
        self.imageService = imageService
    }

    func loadImage() {
        guard let topImageInfo = article.topImageInfo else { return }
        requestState.accept(.loading)
        imageService.loadImage(url: topImageInfo.url) { [weak self] (image) in
            self?.requestState.accept(.loaded)
            self?.imageRelay.accept(image)
        }
    }
}
