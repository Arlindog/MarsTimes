//
//  LocalProvider.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

class LocalProvider: Provider {
    private var registeredFileURLs: [Endpoint: URL] = [:]

    func register(fileURL: URL?, for endpoint: Endpoint) {
        registeredFileURLs[endpoint] = fileURL
    }

    func execute(request: Request, completion: @escaping ((Result<Data, Error>) -> Void)) -> Cancellable {
        guard
            let localFileURL = registeredFileURLs[request.endpoint],
            let fileData = try? Data(contentsOf: localFileURL)
            else {
                completion(.failure(NetworkError.noData))
                return EmptyCancellable()
            }

        completion(.success(fileData))
        return EmptyCancellable()
    }
}
