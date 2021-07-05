//
//  MercuryContentModel.swift
//  AliensTestApp
//
//  Created by Pavlo Deineha on 04.07.2021.
//

import Foundation

struct MercuryContentModel: Codable, Equatable, Identifiable {
    private enum MercuryContentKeys: String, CodingKey {
        case title
        case content
        case leadImageUrl = "lead_image_url"
        case excerpt
        case url
    }
    var id: String { return url }
    
    let title: String?
    let content: String?
    let leadImageUrl: String?
    let excerpt: String?
    let url: String
}
