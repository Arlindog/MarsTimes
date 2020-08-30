//
//  Request.swift
//  MarsTimes
//
//  Created by Arlindo on 8/29/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

typealias Endpoint = String

class Request {
    let method: HTTPMethod
    let endpoint: Endpoint
    let accept: String?

    init(method: HTTPMethod,
         endpoint: Endpoint,
         accept: String?) {
        self.method = method
        self.endpoint = endpoint
        self.accept = accept
    }

    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: endpoint) else { throw NetworkError.invalidUrl }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let accept = accept {
            request.setValue(accept, forHTTPHeaderField: "Accept")
        }

        return request
    }
}

