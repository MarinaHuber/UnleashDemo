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

struct UnsplashImage: Codable, Identifiable, Equatable {
    let id: String
    let urls: UnsplashImageUrls

    static func == (lhs: UnsplashImage, rhs: UnsplashImage) -> Bool {
        return lhs.id == rhs.id
    }
}

struct UnsplashImageUrls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}
