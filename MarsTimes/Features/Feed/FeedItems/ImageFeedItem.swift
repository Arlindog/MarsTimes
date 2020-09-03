//
//  ImageFeedItem.swift
//  MarsTimes
//
//  Created by Arlindo on 9/1/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import RxSwift

protocol ImageFeedItem: FeedItem {
    var image: UIImage? { get }
    var imageChangedObservable: Observable<Void> { get }
    func loadImage()
}
