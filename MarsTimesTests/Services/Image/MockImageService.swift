//
//  MockImageService.swift
//  MarsTimesTests
//
//  Created by Arlindo on 9/4/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import UIKit
@testable import MarsTimes

class MockImageService: ImageServicing {
    var loadImageResult: UIImage?
    func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        completion(loadImageResult)
    }
}
