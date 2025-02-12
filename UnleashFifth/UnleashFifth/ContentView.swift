//
//  ContentView.swift
//  UnleashFifth
//
//  Created by Marina Huber on 12.01.2025..
//

import SwiftUI

struct ContentView: View {
    @State private var selectedImageIndex: Int? = nil
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
                        // Centered Load More Button
                    VStack {
                        Spacer() // Pushes the button to the center vertically
                        Button("Load more...") {
                            viewModel.fetchImages()
                        }
                        .padding()
                        .frame(maxWidth: 200)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.bottom, 150)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchImages()
        }
    }

    var imageBigHScroll:some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
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
            .frame(height: 70)
            .padding(.bottom, 20)
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


