//
//  Bundle+Extensions.swift
//  AliensTestApp
//
//  Created by Pavlo Deineha on 04.07.2021.
//

import Foundation

extension Bundle {
    func load<T: Codable>(name: String) -> T? {
        guard
            let url = url(forResource: name, withExtension: "json"),
            let data = try? Data(contentsOf: url)
        else { return nil }
        
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
