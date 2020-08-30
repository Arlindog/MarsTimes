//
//  RemoteProvider.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

extension URLSessionTask: Cancellable {}

class RemoteProvider: Provider {
    static let shared = RemoteProvider()

    private let session: URLSession

    init(configuration: URLSessionConfiguration = .default) {
        session = URLSession.init(configuration: configuration)
    }

    func execute(request: Request, completion: @escaping ((Result<Data, Error>) -> Void)) -> Cancellable {
        do {
            let urlRequest = try request.asURLRequest()
            let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }

                completion(.success(data))
            }
            dataTask.resume()

            return dataTask
        } catch {
            completion(.failure(error))
            return EmptyCancellable()
        }
    }
}
