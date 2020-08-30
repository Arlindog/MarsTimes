//
//  Provider.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

protocol Cancellable {
    func cancel()
}

struct EmptyCancellable: Cancellable {
    func cancel() {}
}

protocol Provider {
    @discardableResult
    func execute(request: Request, completion: @escaping ((Result<Data, Error>) -> Void)) -> Cancellable
}

extension Provider {
    @discardableResult
    func execute<Object: Decodable>(request: Request, completion: @escaping ((Result<Object, Error>) -> Void)) -> Cancellable {
        return execute(request: request) { (result) in
            switch result {
            case .success(let data):
                do {
                    let object = try JSONDecoder().decode(Object.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
