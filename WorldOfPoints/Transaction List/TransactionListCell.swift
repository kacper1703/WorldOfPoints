//
//  TransactionListCell.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 29/03/2024.
//

import SwiftUI

struct TransactionListCell: View {

    let transaction: Transaction

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        let cornerRadius: CGFloat = 20

        HStack(alignment: .top) {
            titleAndDescriptionView
            Spacer()
            pointsView
        }
        .padding()
        .background(Color.primaryBackground)
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    .white,
                    lineWidth: colorScheme == .light ? 0 : 1
                )
        )
        .shadow(
            color: colorScheme == .light ? .black.opacity(0.2) : .clear,
            radius: colorScheme == .light ? 4 : 0
        )
    }

    @ViewBuilder
    private var titleAndDescriptionView: some View {
        VStack(alignment: .leading) {
            Text(transaction.transactionDetail.bookingDate.formatted())
                .font(.footnote)
                .foregroundStyle(.primaryFont.secondary)
            
            Text(transaction.partnerDisplayName)
                .font(.headline)
                .foregroundStyle(.primaryFont)
            
            if let description = transaction.transactionDetail.description {
                Text(description)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundStyle(.secondary)
            }
        }
    }

    @ViewBuilder
    private var pointsView: some View {
        VStack(alignment: .trailing) {
            Text(transaction.transactionDetail.value.amount.formatted())
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundStyle(.primaryFont)
            
            Text(transaction.transactionDetail.value.currency)
                .font(.caption)
                .foregroundStyle(.primaryFont.secondary)
        }
    }
}

#Preview {
    VStack {
        Group {
            TransactionListCell(transaction: .mockNoDescription)
            TransactionListCell(transaction: .mock)
            TransactionListCell(transaction: .mockLongDescription)
        }
        .padding()
    }
}
