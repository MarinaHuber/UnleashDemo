//
//  SmallImage.swift
//  UnleashFifth
//
//  Created by Marina Huber on 29.01.2025..
//

import SwiftUI

struct SmallImage: View {
    @Binding var selectedImageIndex: Int?
    @Environment(\.scrollViewProxy) private var scrollProxy
    @EnvironmentObject var viewModel: ContentViewModel
    let image: UnsplashImage
    let index: Int

    var body: some View {
        ZStack {
            if selectedImageIndex == index {
                    // Highlight selection red
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.red, lineWidth: 5)
                    .frame(width: 50, height: 50)
            }
            AsyncImage(url: URL(string: image.urls.thumb)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 50, height: 50)
                case .success(let image):
                    image
                        .centerCropped()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "")
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
        }
        .onTapGesture {
            withAnimation {
                selectedImageIndex = index
                scrollProxy?.scrollTo(index, anchor: .top) // Sync scroll to big view
            }
        }
        .onAppear {
            if selectedImageIndex == nil, !viewModel.images.isEmpty {
                selectedImageIndex = 0 // Default to the first image
                scrollProxy?.scrollTo(0, anchor: .top)
            }
        }
    }
}
