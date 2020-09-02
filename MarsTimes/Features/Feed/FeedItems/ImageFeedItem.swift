//
//  ImageFeedItem.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import UIKit

protocol ImageFeedItem: FeedItem {
    var image: UIImage? { get }
    func loadImage()
}
