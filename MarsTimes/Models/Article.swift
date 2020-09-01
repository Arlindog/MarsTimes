//
//  Article.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

struct Article: Decodable {
    let title: String
    let images: [ArticleImageInfo]
    let body: String

    var topImageInfo: ArticleImageInfo? {
        return images.first {
            $0.isTopImage
        }
    }
}

struct ArticleImageInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case isTopImage = "top_image"
        case url
        case width
        case height
    }
    let isTopImage: Bool
    let url: String
    let width: Int
    let height: Int
}
