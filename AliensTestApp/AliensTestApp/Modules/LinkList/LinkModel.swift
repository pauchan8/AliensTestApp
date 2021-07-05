//
//  LinkModel.swift
//  AliensTestApp
//
//  Created by Pavlo Deineha on 04.07.2021.
//

import Foundation

struct Link: Codable, Identifiable {
    let id: String
    let name: String
    let url: String
}

class LinkFactory {
    private init() {}
    
    class func base() -> [Link] {
        return Bundle.main.load(name: "links") ?? []
    }
}
