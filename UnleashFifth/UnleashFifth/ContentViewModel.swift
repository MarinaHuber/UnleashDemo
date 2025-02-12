//
//  ContentViewModel.swift
//  UnleashFifth
//
//  Created by Marina Huber on 12.01.2025..
//

import Combine
import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var images: [UnsplashImage] = []
    @Published var isLoading: Bool = false
    private var cancellables: AnyCancellable?
    private var currentPage: Int = 1
    private var totalPages = 0

    func fetchImages() {
        //Unsplash's API rate limits (50 requests in hour) so delay here
        currentPage = 1
        images = [] // Clear existing patterns for pagination
        self.fetchImages(page: currentPage)
    }

    func fetchImages(page: Int) {
        guard !isLoading else { return }

        isLoading = true
        cancellables = APIServiceLoader.client.request(.search(page: page), model: UnsplashResponse.self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Publisher stopped observing")
                    case .failure(let error):
                        print("Error: \(error) passed to our future (single value expected)")
                        self.isLoading = false
                    }
                },
                receiveValue: { [weak self] deserializedData in
                    self?.images = deserializedData.results
                    self?.totalPages = deserializedData.totalPages
                    self?.images.append(contentsOf: deserializedData.results)
                    print("Loaded page \(String(describing: self?.currentPage)) of \(String(describing: self?.totalPages))")

                })
    }

        //MARK: - PAGINATION
    func loadMoreContent(currentItem: UnsplashImage?) {
        guard currentPage < totalPages else { return }

        if let currentItem = currentItem,
           let lastItem = images.last,
           currentItem.id == lastItem.id {

            currentPage += 1
            self.fetchImages(page: currentPage)
        }
    }
}

