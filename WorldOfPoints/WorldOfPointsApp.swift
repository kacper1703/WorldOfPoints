//
//  WorldOfPointsApp.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 29/03/2024.
//

import SwiftUI

@main
struct WorldOfPointsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: .init(networkService: NetworkServiceMock())
            )
        }
    }
}
