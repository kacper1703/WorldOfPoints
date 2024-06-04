//
//  TransactionsListView.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 29/03/2024.
//

import SwiftUI
import SFSymbols

struct TransactionsListView: View {

    @StateObject private var viewModel: TransactionsListViewViewModel

    init(transactions: [Transaction]) {
        _viewModel = .init(wrappedValue: .init(transactions: transactions))
    }

    var body: some View {
        ScrollView {
            transactionsList
            pointsFooter
        }
        .navigationTitle(
            Text("Transactions list",
                 comment: "Title on the navigation bar of transactions list")
        )
        .toolbar {
            optionsMenu
        }
        .navigationDestination(for: Transaction.self) {
            TransactionDetailsView(transaction: $0)
        }
    }

    @ViewBuilder
    private var transactionsList: some View {
        LazyVStack {
            ForEach(viewModel.transactions) { transaction in
                NavigationLink(value: transaction) {
                    TransactionListCell(transaction: transaction)
                }
                .padding(.horizontal)
                .buttonStyle(PlainButtonStyle())
            }
        }
        .animation(.default, value: viewModel.transactions)
    }

    @ViewBuilder
    private var optionsMenu: some View {
        Menu {
            filterMenu
        } label: {
            Label(symbol: SFSymbol.ellipsisCircle) {
                Text("Options",
                     comment: "Title of the oprions menu on transaction list"
                )
            }
        }
    }

    @ViewBuilder
    private var filterMenu: some View {
        Menu {
            Picker(selection: $viewModel.selectedCategory,
                   label: Text("Category filter",
                               comment: "Title of the category filter picker")
            ) {
                Text("None",
                     comment: "Name of no category filter option")
                .tag(Optional<Int>(nil))

                ForEach(viewModel.categories, id: \.self) {
                    Text(String($0))
                        .tag(Optional<Int>($0))
                }
            }
        } label: {
            Label(symbol: SFSymbol.filter) {
                Text("Filter by category",
                     comment: "Title of category filter")
            }
        }
    }

    @ViewBuilder
    private var pointsFooter: some View {
        Text(footerString)
            .padding(.vertical, 20)
    }

    private var footerString: AttributedString {
        var attributedString = AttributedString(localized: "Total points: %@",
                                                comment: "Text on label that shows total points count")
        if let numberRange = attributedString.range(of: "%@") {
            var numberFormatted = AttributedString(viewModel.totalPoints.formatted())
            numberFormatted.font = Font.body.bold()
            attributedString.replaceSubrange(numberRange,
                                             with: numberFormatted)
        }
        return attributedString
    }
}

#Preview {
    NavigationStack {
        TransactionsListView(
            transactions: TransactionsResponse.mock.items
        )
    }
}
