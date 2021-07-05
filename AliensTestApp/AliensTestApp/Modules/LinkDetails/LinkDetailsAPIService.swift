//
//  LinkDetailsAPIService.swift
//  AliensTestApp
//
//  Created by Pavlo Deineha on 04.07.2021.
//

import Combine
import Foundation

struct LinkDetailsAPIService: APIService {
    private let baseUrl = "https://mercury-parser-aliens.herokuapp.com"
    let session: URLSession
    
    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }
    
    func parsedReaderHTML(_ link: String) -> AnyPublisher<MercuryContentModel, Error>? {
        var components = URLComponents(string: baseUrl + "/api/parse")
        components?.queryItems = [URLQueryItem(name: "url", value: link)]
        
        guard let url = components?.url else { return nil }

        return load(URLRequest(url: url))
    }
}
