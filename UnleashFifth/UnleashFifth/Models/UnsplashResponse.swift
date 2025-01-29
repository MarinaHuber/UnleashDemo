//
//  File.swift
//  UnleashFifth
//
//  Created by Marina Huber on 12.01.2025..
//

import Foundation

struct UnsplashResponse: Codable {
    var totalPages: Int = 0
    let results: [UnsplashImage]
}

struct UnsplashImage: Codable, Identifiable {
    let id: String
    let urls: UnsplashImageUrls
}

struct UnsplashImageUrls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}
