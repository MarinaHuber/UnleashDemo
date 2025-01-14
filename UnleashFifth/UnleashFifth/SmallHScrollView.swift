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
    @EnvironmentObject var viewModel: ContentViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(viewModel.images.indices, id: \.self) { index in
                    ZStack {
                        if selectedImageIndex == index {
                                // Highlight selection
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red, lineWidth: 5)
                                .frame(width: 50, height: 50)
                        }
                        AsyncImage(url: URL(string: viewModel.images[index].urls.thumb)) { image in
                            image
                                .centerCropped()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 50, height: 50)
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
            .padding()
            .background(Color.blue)
            .frame(height: 110) // Fixed height for the menu
        }
    }
}
