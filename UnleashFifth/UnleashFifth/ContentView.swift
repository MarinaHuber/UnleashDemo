//
//  ContentView.swift
//  UnleashFifth
//
//  Created by Marina Huber on 12.01.2025..
//

import SwiftUI

struct ContentView: View {
    @State private var selectedImageIndex: Int? = nil
    @State private var fetchedImage: Image?
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        ScrollViewReader { scrollProxy in
            ZStack(alignment: .bottom) {
                if viewModel.images.isEmpty {
                    ProgressView("Loading pictures...")
                } else {
                    imageBigHScroll
                    imageSmallHScroll
                        .environment(\.scrollViewProxy, scrollProxy)
                    Button("Load more..", action: viewModel.fetchImages)
                        .padding()
                        .frame(maxWidth: 200)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                        .position(CGPoint(x: 200, y: 500))
                }
            }
        }
        .onAppear {
            viewModel.fetchImages()
        }
    }

    var imageBigHScroll:some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(viewModel.images.indices, id: \.self) { index in
                    ZStack {
                        AsyncImage(url: URL(string: viewModel.images[index].urls.regular)) { image in
                            image
                                .centerCropped()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        } placeholder: {
                            ProgressView()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
                        }
                    }
                    .id(index) // Attach an ID for scroll synchronization
                    
                }
            }
        }
    }

    var imageSmallHScroll: some View {
        SmallHScrollView(selectedImageIndex: $selectedImageIndex, viewModel: viewModel)
            .environmentObject(viewModel)
            .padding(.bottom, 10)
    }

}


extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
                .ignoresSafeArea()
        }
    }
}

struct ScrollViewProxyKey: EnvironmentKey {
    static let defaultValue: ScrollViewProxy? = nil
}

extension EnvironmentValues {
    var scrollViewProxy: ScrollViewProxy? {
        get { self[ScrollViewProxyKey.self] }
        set { self[ScrollViewProxyKey.self] = newValue }
    }
}


