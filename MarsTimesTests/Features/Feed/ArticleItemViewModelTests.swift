//
//  ArticleItemViewModelTests.swift
//  MarsTimesTests
//
//  Created by Arlindo on 9/4/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import MarsTimes

class ArticleItemViewModelTests: XCTestCase, TestObserving {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)

    var viewModel: ArticleItemViewModel!
    var imageService: MockImageService!

    override func setUp() {
        super.setUp()
        imageService = MockImageService()
        let article = Article(title: "Test",
                              images: [ArticleImageInfo(isTopImage: true, url: "" , width: 0, height: 0)],
                              body: "")
        viewModel = ArticleItemViewModel(article: article, imageService: imageService)
    }

    func testImageChanged() {
        imageService.loadImageResult = #imageLiteral(resourceName: "test_feed_image")
        let imageChangedObserver = observe(viewModel.imageChangedObservable.map { _ in true })
        viewModel.loadImage()
        XCTAssertTrue(imageChangedObserver.events.last?.value.element)
    }

    func testFailedImageLoad() {
        imageService.loadImageResult = nil

        let showImageLoadErrorStateObserver = observe(viewModel.showImageLoadErrorState.asObservable())
        let imageChangedObserver = observe(viewModel.imageChangedObservable.map { _ in true })

        let expectedShowImageLoadStates: [Bool] = [
            // idle
            false,
            // loading
            false,
            // error
            true,
            // loading
            false,
            // loaded
            false
        ]

        viewModel.loadImage()
        XCTAssertNil(imageChangedObserver.events.last?.value.element)


        imageService.loadImageResult = #imageLiteral(resourceName: "test_feed_image")
        viewModel.loadImage()

        XCTAssertTrue(imageChangedObserver.events.last?.value.element)
        XCTAssertEqual(showImageLoadErrorStateObserver.events.compactMap { $0.value.element }, expectedShowImageLoadStates)
    }
}
