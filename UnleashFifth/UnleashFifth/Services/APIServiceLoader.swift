//
//  APIServiceLoader.swift
//  UnleashFifth
//
//  Created by Marina Huber on 13.01.2025..
//

import Foundation
import Combine

enum APIServiceError: Error {
    case responseError
    case parseError(Error)
}


struct APIServiceLoader {

    static let client = APIServiceLoader()
    private init() {}

    func request<T: Decodable>(_ endpoint: Endpoint, model: T.Type) -> Future<T, APIServiceError> {
        return Future { promise in
            guard let url = endpoint.url else {
                return promise(.failure(.responseError))
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    promise(.failure(.responseError))
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    promise(.failure(.responseError))
                    return
                }

                guard let data = data else {
                    promise(.failure(.responseError))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .iso8601
                    let model = try decoder.decode(T.self, from: data)

                    if let data = model as? UnsplashResponse, data.results.isEmpty {
                        promise(.failure(.responseError))
                        return
                    }

                    promise(.success(model))
                } catch {
                    promise(.failure(.parseError(error)))
                }
            }

            task.resume()
        }
    }
}

