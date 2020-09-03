//
//  FeedViewModel.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import RxSwift
import RxCocoa

class FeedViewModel {
    private let disposeBag = DisposeBag()
    private let feedService: FeedService
    private let feedItemRelay = BehaviorRelay<[FeedItem]>(value: [])
    private let requestState = BehaviorRelay<RequestState>(value: .idle)
    private let openFeedItemRelay = PublishRelay<FeedItemType>()
    private let reloadFeedHeightRelay = PublishRelay<Void>()

    private var feedItemDriver: Driver<[FeedItem]> {
        return feedItemRelay.asDriver()
    }

    var isLoadingFeedDriver: Driver<Bool> {
        return requestState.asDriver()
            .filter { $0 != .refreshing }
            .map { $0 == .loading }
    }

    var isRefreshingFeedDriver: Driver<Bool> {
        return requestState.asDriver()
            .filter { $0 != .loading }
            .map { $0 == .refreshing }
    }

    var openFeedItemSignal: Signal<FeedItemType> {
        return openFeedItemRelay.asSignal()
    }

    var reloadFeedDriver: Driver<Void> {
        return feedItemDriver
            // Ignore initial empty value
            .skip(1)
            .map { _ in }
    }

    var reloadFeedHeight: Signal<Void> {
        return reloadFeedHeightRelay.asSignal()
    }

    var feedItemCount: Int {
        return feedItemRelay.value.count
    }

    init(feedService: FeedService = .shared) {
        self.feedService = feedService
        setupBindings()
    }

    private func setupBindings() {
        let imageItems: Observable<ImageFeedItem> = feedItemRelay.asObservable()
            .flatMap { (feedItem) -> Observable<ImageFeedItem> in
                Observable.from(feedItem)
                    .compactMap { $0 as? ImageFeedItem }
            }

        imageItems
            .flatMap { (imageFeedItem) -> Observable<Void> in
                return imageFeedItem.imageChangedObservable
                    // Delay the event so that the Article Cell has a chance to layout its views
                    // before perfoming updates to the table view. This will ensure
                    // we get the correct height for the cell.
                    .delay(.milliseconds(100), scheduler: MainScheduler.instance)
            }
            .bind(to: reloadFeedHeightRelay)
            .disposed(by: disposeBag)
    }

    func loadFeed(type: RequestType = .standard) {
        switch type {
        case .standard:
            requestState.accept(.loading)
        case .refresh:
            requestState.accept(.refreshing)
        }
        feedService.fetchFeed { [weak self] result in
            self?.requestState.accept(.loaded)
            switch result {
            case .success(let articles):
                let items = articles.map {
                    ArticleItemViewModel(article: $0)
                }
                self?.feedItemRelay.accept(items)
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
        return feedItemRelay.value[indexPath.item]
    }

    func didSelectFeedItem(at indexPath: IndexPath) {
        guard let feedItem = getFeedItem(at: indexPath) else { return }
        if let feedItem = feedItem as? ArticleItemViewModel {
            openFeedItemRelay.accept(.article(feedItem))
        }
    }
}
