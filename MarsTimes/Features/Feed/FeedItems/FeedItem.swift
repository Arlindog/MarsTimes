//
//  FeedItem.swift
//  MarsTimes
//
//  Created by Arlindo on 8/31/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

enum FeedItemType {
    case article(ArticleItemViewModel)
}

protocol FeedItem {
    var cellIdentifier: String { get }
}
