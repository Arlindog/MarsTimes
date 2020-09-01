//
//  ImageService.swift
//  MarsTimes
//
//  Created by Arlindo on 8/31/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import UIKit

extension Request {
    static func imageRequest(imageUrl: String) -> Request {
        return Request(method: .get,
                       endpoint: imageUrl,
                       accept: "image/*")
    }
}

protocol ImageServicing {
    func loadImage(url: String, completion: @escaping (UIImage?) -> Void)
}

class ImageService: ImageServicing {
    static let shared = ImageService()

    private let provider: Provider
    private let cachedImages = NSCache<NSString, UIImage>()

    init(provider: Provider = RemoteProvider.shared) {
        self.provider = provider
    }

    func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = loadCachedImage(for: url) {
            completion(cachedImage)
            return
        }
        provider.execute(request: Request.imageRequest(imageUrl: url)) { [weak self] result in
            switch result {
            case .success(let data):
                let image = UIImage(data: data)
                self?.updateCache(with: image, for: url)
                completion(image)
            case .failure(let error):
                print("Error loading image: \(error)")
                completion(nil)
            }
        }
    }

    private func loadCachedImage(for url: String) -> UIImage? {
        return cachedImages.object(forKey: url as NSString)
    }

    private func updateCache(with image: UIImage?, for url: String) {
        guard let image = image else { return }
        DispatchQueue.main.async { [weak self] in
            self?.cachedImages.setObject(image, forKey: url as NSString)
        }
    }
}
