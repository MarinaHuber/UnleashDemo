    //
    //  SmallHScrollView.swift
    //  UnleashFifth
    //
    //  Created by Marina Huber on 14.01.2025..
    //


import SwiftUI

struct SmallHScrollView: View {
    @Binding var selectedImageIndex: Int?
    @Environment(\.scrollViewProxy) private var scrollProxy
    @StateObject var viewModel: ContentViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.images.indices, id: \.self) { index in
                    SmallImage(selectedImageIndex: $selectedImageIndex, image: viewModel.images[index], index: index)
                        .onAppear {
                            viewModel.loadMoreIfNeeded(currentItem: viewModel.images[index])
                        }
                        .environment(\.scrollViewProxy, scrollProxy)
                }
                if viewModel.isLoadingMore {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .padding()
            .background(Color.blue)
            .frame(height: 110)

            // NOTE: optional handle
            .background(GeometryReader { geometry in
                Color.clear.onChange(of: geometry.frame(in: .global).minX) { value, _ in
                    handleScroll(value)
                }
            })
        }
    }
           // NOTE: optional handle
        private func handleScroll(_ offset: CGFloat) {
                // Load more when scrolling near end
            if offset < -300 && !viewModel.isLoadingMore {
                viewModel.loadImages(page: viewModel.currentPage)
            }
        }

}
