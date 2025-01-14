//
//  UnleashFifthApp.swift
//  UnleashFifth
//
//  Created by Marina Huber on 12.01.2025..
//

import SwiftUI

@main
struct UnleashFifthApp: App {
    @StateObject var viewModel = ContentViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
