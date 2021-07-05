//
//  APIService.swift
//  AliensTestApp
//
//  Created by Pavlo Deineha on 04.07.2021.
//

import Combine
import Foundation

protocol APIService {
    var session: URLSession { get }
    func load<T: Codable>(_ request: URLRequest, queue: DispatchQueue, retries: Int) -> AnyPublisher<T, Error>
}

extension APIService {
    func load<T: Codable>(_ request: URLRequest, queue: DispatchQueue = .main, retries: Int = 0) -> AnyPublisher<T, Error> {
        return session.dataTaskPublisher(for: request)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw APIServiceError.responseUnsuccessful
                }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: queue)
            .retry(retries)
            .eraseToAnyPublisher()
    }
}
