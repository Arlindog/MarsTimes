//
//  FeedServiceTests.swift
//  MarsTimesTests
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import XCTest
@testable import MarsTimes

class FeedServiceTests: XCTestCase {
    private var localProvider: LocalProvider!
    private var service: FeedService!

    override func setUp() {
        super.setUp()
        localProvider = LocalProvider()
        service = FeedService(provider: localProvider)
    }

    func testFetchFeed() {
        localProvider.register(fileURL: Bundle.test.url(forResource: "mock_feed",
                                                        withExtension: ".json"),
                               for: Endpoint.feedEnpoint)

        let fetchFeedExpectation = expectation(description: "Fetching Feed Item")

        service.fetchFeed { (result) in
            switch result {
            case .success(let articles):
                XCTAssertEqual(articles.count, 3)
            case .failure(let error):
                XCTFail("Failed fetching feed: \(error)")
            }
            fetchFeedExpectation.fulfill()
        }

        wait(for: [fetchFeedExpectation], timeout: 0.5)
    }
}
