//
//  FeedService.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

extension Endpoint {
    static let feedEnpoint: String = "https://s1.nyt.com/ios-newsreader/candidates/test/articles.json"
}

fileprivate extension Request {
    static func feedRequest() -> Request {
        return Request(method: .get,
                       endpoint: Endpoint.feedEnpoint,
                       accept: "application/json")
    }
}

typealias FeedResult = Result<[Article], Error>

class FeedService {
    static let shared = FeedService()
    let provider: Provider

    init(provider: Provider = RemoteProvider.shared) {
        self.provider = provider
    }

    func fetchFeed(completion: @escaping (FeedResult) -> Void) {
        provider.execute(request: Request.feedRequest(),
                         completion: completion)
    }
}
