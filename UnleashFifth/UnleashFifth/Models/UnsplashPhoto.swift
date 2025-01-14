//
//  File.swift
//  UnleashFifth
//
//  Created by Marina Huber on 12.01.2025..
//

import Foundation

struct UnsplashResponse: Codable {
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let urls: UnsplashPhotoUrls

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct UnsplashPhotoUrls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}
