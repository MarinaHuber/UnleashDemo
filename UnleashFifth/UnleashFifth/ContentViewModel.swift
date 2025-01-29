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
    private var cancellables: AnyCancellable?

    func fetchImages(page: Int) {
        cancellables = APIServiceLoader.client.request(.search(page: page), model: UnsplashResponse.self)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Publisher stopped observing")
                    case .failure(let error):
                        print("Error: \(error) passed to our future (single value expected)")
                    }
                },
                receiveValue: { [weak self] deserializedData in
                    self?.images = deserializedData.results
                })
    }
}

