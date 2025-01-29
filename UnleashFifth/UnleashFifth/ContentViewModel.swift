//
//  ContentViewModel.swift
//  UnleashFifth
//
//  Created by Marina Huber on 12.01.2025..
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var images: [UnsplashImage] = []
    @Published var currentPage = 1
    @Published var totalPages = 1
    @Published var isLoadingMore = false
    
    private var canLoadMorePages: Bool {
        !isLoadingMore && currentPage < totalPages
    }

    func fetchImages() {
        //Unsplash's API rate limits (50 requests in hour) so delay here
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.loadImages(page: self.currentPage)
        }
    }

        // Load more images with pagination
    func loadImages(page: Int) {
        isLoadingMore = true

        APIServiceLoader.client.request(.search(page: page), model: UnsplashResponse.self) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.images.append(contentsOf: response.results)
                    self.totalPages = response.totalPages
                case .failure(let error):
                    print("Error loading images: \(error)")
                }
                self.isLoadingMore = false
            }
        }
    }

    func loadMoreIfNeeded(currentItem: UnsplashImage?) {
        guard canLoadMorePages else { return }

        if let currentItem = currentItem,
           let lastItem = images.last,
           currentItem.id == lastItem.id {
            currentPage += 1
            loadImages(page: currentPage)
        }
    }
}
