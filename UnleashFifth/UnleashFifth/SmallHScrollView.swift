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
            LazyHStack(spacing: 10) {
                if viewModel.images.isEmpty {
                    ProgressView("Loading Images...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                } else {
                    ForEach(viewModel.images.indices, id: \.self) { index in
                        SmallImage(selectedImageIndex: $selectedImageIndex, imageUnsplash: viewModel.images[index], index: index)
                            .environment(\.scrollViewProxy, scrollProxy)
                    }
                }
            }
            .padding()
            .background(Color.blue)

        }
    }

}
