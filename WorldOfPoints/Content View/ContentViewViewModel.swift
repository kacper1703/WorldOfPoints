//
//  ContentViewViewModel.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 30/03/2024.
//

import Combine

final class ContentViewViewModel: ObservableObject {

    enum State {
        case loading
        case loaded([Transaction])
        case error(Error)
    }

    let networkService: NetworkServiceProtocol
    
    @Published var state: State
    @Published var isNetworkReachable: Bool

    private var cancellables: Set<AnyCancellable> = []

    init(
        networkService: any NetworkServiceProtocol,
        state: State = .loading
    ) {
        self.networkService = networkService
        self.state = state
        self.isNetworkReachable = networkService.isNetworkReachable
        setUpObservers()
    }

    private func setUpObservers() {
        networkService.networkReachablePublisher
            .removeDuplicates()
            .receiveOnMainThread()
            .weakAssign(to: \.isNetworkReachable, on: self)
            .store(in: &cancellables)
    }

    func loadData() {
        guard !isRunningForPreviews else {
            return
        }

        state = .loading
        Task {
            do {
                let transactions = try await networkService.getTransactions()
                await MainActor.run {
                    state = .loaded(transactions)
                }
            } catch {
                await MainActor.run {
                    state = .error(error)
                }
            }
        }
    }
}
