//
//  File.swift
//  UnleashFifth
//
//  Created by Marina Huber on 14.01.2025..
//

import Foundation

struct UnsplashPhoto: Codable {
    let id: String
    let urls: UnsplashPhotoUrls
}

struct UnsplashPhotoUrls: Codable {
    let raw, full, regular, small: String
    let thumb: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
    }
}
