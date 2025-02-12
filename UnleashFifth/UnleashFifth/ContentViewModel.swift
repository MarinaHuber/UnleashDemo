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
    var currentPage: Int = 1
    private var totalPages: Int = 5 // Limit to max pages to fetch due Unsplash hour limit
    
    func fetchImages() {
        
        guard currentPage <= totalPages else {
            print("Reached max pages to fetch, exiting fetchImages.")
            return
        }
        
        let endpoint = Endpoint.search(page: currentPage)
        
        DispatchQueue.global(qos: .background).async {
            self.cancellables = APIServiceLoader.client.request(endpoint, model: UnsplashResponse.self)
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
                    receiveValue: { deserializedData in
                        self.images.append(contentsOf: deserializedData.results)
                        print("Loaded page \(self.currentPage) of \(self.totalPages)")
                        
                        self.currentPage += 1  // Increment the current page
                        self.fetchImages()
                    })
        }
    }
}

