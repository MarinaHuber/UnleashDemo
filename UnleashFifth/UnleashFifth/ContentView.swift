//
//  ContentView.swift
//  UnleashFifth
//
//  Created by Marina Huber on 12.01.2025..
//

import SwiftUI

struct ContentView: View {
    @State private var selectedColorIndex: Int? = nil
    let colors: [Color] = [.blue, .pink, .cyan, .purple, .orange, .yellow]
    @State private var fetchedImage: Image?
    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        ScrollViewReader { scrollProxy in
            ZStack(alignment: .bottom) {
                    // Full-Screen Big Collection View
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(colors.indices, id: \.self) { index in
                            ZStack {
                                colors[index]
                                    .ignoresSafeArea()
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // Full-screen width and height
                                Text("\(index + 1)")
                                    .font(.system(size: 150))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .id(index) // Attach an ID for scroll synchronization
                        }
                    }
                }

                    // Small Collection View (Menu)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(colors.indices, id: \.self) { index in
                            ZStack {
                                if selectedColorIndex == index {
                                        // Highlight selection
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 4)
                                        .frame(width: 50, height: 50)
                                }
                                fetchedImage
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                Text("\(index + 1)")
                                    .font(.system(size: 13))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .onTapGesture {
                                withAnimation {
                                    selectedColorIndex = index
                                    scrollProxy.scrollTo(index, anchor: .top) // Sync scroll to big view
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.green)
                    .frame(height: 70) // Fixed height for the menu
                }
            }
        }
        .onAppear {
            Task {
                fetchedImage = await viewModel.fetchImage(from: "https://images.unsplash.com/photo-1491895200222-0fc4a4c35e18?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2OTY1ODd8MHwxfHNlYXJjaHwxfHxwYXR0ZXJufGVufDB8fHx8MTczNjgwMjcyNHww&ixlib=rb-4.0.3&q=80&w=400")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
