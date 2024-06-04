//
//  TransactionsListViewViewModel.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 29/03/2024.
//

import Combine

final class TransactionsListViewViewModel: ObservableObject {

    @Published var selectedCategory: Int?

    @Published private(set) var transactions: [Transaction]
    @Published private(set) var totalPoints: Int = 0

    private(set) var categories: [Int] = []

    private let allTransactions: [Transaction]
    private var cancellables: Set<AnyCancellable> = []

    internal init(
        transactions: [Transaction],
        sortedByDateAscending: Bool = true
    ) {
        self.allTransactions = transactions
        self.transactions = transactions
        categories = allTransactions.map { $0.category }.unique.sorted()
        setUpObservers()
    }

    private func setUpObservers() {
        $selectedCategory
            .removeDuplicates()
            .map { [unowned self] category in
                if let category {
                    allTransactions.filter {
                        $0.category == category
                    }
                } else {
                    allTransactions
                }
            }
            .map {
                $0.sorted(by: \.transactionDetail.bookingDate,
                          ascending: false)
            }
            .assign(to: \.transactions, on: self)
            .store(in: &cancellables)

        $transactions
            .sink { [unowned self] in
                totalPoints = $0
                    .compactMap { $0.transactionDetail.value.amount }
                    .reduce(0, +)
            }
            .store(in: &cancellables)
    }
}
