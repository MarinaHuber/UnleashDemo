//
//  ContentViewModel.swift
//  UnleashFifth
//
//  Created by Marina Huber on 14.01.2025..
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {

    func fetchImage(from urlString: String) async -> Image? {
        guard let url = URL(string: urlString) else {
            return nil
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            } else {
                return nil
            }
        } catch {
            print("Failed to fetch image: \(error)")
            return nil
        }
    }

    
}
