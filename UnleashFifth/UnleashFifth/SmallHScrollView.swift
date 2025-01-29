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
                        .environment(\.scrollViewProxy, scrollProxy)
                }
            }
            .padding()
            .background(Color.blue)
            .frame(height: 110)
        }
    }
}
