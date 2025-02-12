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
    let imageUnsplash: UnsplashImage
    let index: Int

    var body: some View {
        ZStack {
            if selectedImageIndex == index {
                // Highlight selection red
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.red, lineWidth: 5)
                    .frame(width: 50, height: 50)
            }
                // Image
            AsyncImage(url: URL(string: imageUnsplash.urls.thumb)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .centerCropped()
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "")
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }.frame(width: 50, height: 50)

            if viewModel.images.isEmpty {
                Color.secondary
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
                ProgressView()
                    .padding()
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
