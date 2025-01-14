//
//  ContentViewModel.swift
//  UnleashFifth
//
//  Created by Marina Huber on 12.01.2025..
//

import Foundation
import SwiftUI

@MainActor
class ContentViewModel: ObservableObject {
    @Published var images: [UnsplashPhoto] = []

    func fetchImages() async {
        do {
            await APIServiceLoader.client.request(.search(), model: UnsplashResponse.self) { result in
                switch result {
                case .success(let deserializedData):
                    Task {
                        self.images = deserializedData.results
                    }
                case .failure(let error):
                    print("error\(error)")
                }
            }
        }
    }

    
}
