//
//  File.swift
//  UnleashFifth
//
//  Created by Marina Huber on 12.01.2025..
//

import Foundation

struct UnsplashResponse: Codable {
    let totalPages: Int
    let results: [UnsplashImage]
}

struct UnsplashImage: Codable, Identifiable {
    let id: String
    let urls: UnsplashImageUrls

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct UnsplashImageUrls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}
