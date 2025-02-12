//
//  APIEndpoints.swift
//  UnleashFifth
//
//  Created by Marina Huber on 13.01.2025..
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    static func search(_ query: String = "pattern orange door", page: Int) -> Endpoint {
        return Endpoint(
            path: "/search/photos",
            queryItems: [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "per_page", value: "30"),
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "client_id", value: Keys.publicKey)
            ]
        )
    }
}
extension Endpoint {
    var url: URL? {
        var components        = URLComponents()
        components.scheme     = "https"
        components.host       = "api.unsplash.com"
        components.path       = path
        components.queryItems = queryItems
        return components.url
    }
}
