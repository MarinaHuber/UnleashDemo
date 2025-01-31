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
    private var currentPage: Int = 1
    private var totalPages = 0

    private var canLoadMorePages: Bool {
        currentPage < totalPages
    }

    func fetchImages() {
        //Unsplash's API rate limits (50 requests in hour) so delay here
       // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        currentPage = 1 // Clear existing page for start
        images = [] // Clear existing patterns for pagination
        self.loadImages()
      //  }
    }

        // Load more images with pagination
    func loadImages() {
        APIServiceLoader.client.request(.search(page: currentPage), model: UnsplashResponse.self) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.totalPages = response.totalPages
                    self.images.append(contentsOf: response.results)

                    print("Loaded page \(self.currentPage) of \(self.totalPages)")

                case .failure(let error):
                    print("Error loading images: \(error)")
                }
            }
        }
    }

        //MARK: - PAGINATION
    func loadMoreContent(currentItem: UnsplashImage?) {
        guard currentPage < totalPages else { return }
        if let currentItem = currentItem,
           let lastItem = images.last,
           currentItem.id == lastItem.id {
            currentPage += 1
            loadImages()
        }
    }
}
