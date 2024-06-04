//
//  ContentView.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 29/03/2024.
//

import Reachability
import SwiftUI

struct ContentView: View {

    @StateObject var viewModel: ContentViewViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color.primaryBackground
                    .ignoresSafeArea()
                content
            }
        }
        .onAppear(perform: viewModel.loadData)
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isNetworkReachable {
            switch viewModel.state {
                case .loading:
                    ProgressView()
                case .loaded(let transactions):
                    TransactionsListView(transactions: transactions)
                case .error(let error):
                    errorView(error)
            }
        } else {
            offlineView
        }
    }


    private func errorView(_ error: Error) -> some View {
        VStack(spacing: 20) {
            Text("There was an error loading the data: \(error.localizedDescription)",
                 comment: "Text displayed on content view when there was a problem loading data.")
            .font(.footnote)
            .multilineTextAlignment(.center)

            Button {
                viewModel.loadData()
            } label: {
                Text("Retry",
                     comment: "Text on button that retries loading data on content view")
            }
            .foregroundStyle(.primaryBackground)
            .buttonStyle(BorderedProminentButtonStyle())
        }
        .padding()
    }


    private var offlineView: some View {
        Text("Your are offline. Please connect to the internet to use the app.",
             comment: "Text on offline screen when user is offline.")
        .font(.caption)
        .foregroundStyle(.primaryFont)
    }
}

#Preview("Loaded") {
    ContentView(
        viewModel: .init(
            networkService: NetworkServiceMock(),
            state: .loaded(TransactionsResponse.mock.items)
        )
    )
}

#Preview("Loading") {
    ContentView(
        viewModel: .init(
            networkService: NetworkServiceMock(),
            state: .loading
        )
    )
}

#Preview("Error") {
    ContentView(
        viewModel: .init(
            networkService: NetworkServiceMock(),
            state: .error(NetworkServiceMock.CustomError.randomError)
        )
    )
}

#Preview("Offline") {
    ContentView(
        viewModel: .init(
            networkService: NetworkServiceMock(networkReachable: false)
        )
    )
}
