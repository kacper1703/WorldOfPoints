//
//  TransactionDetailsView.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 30/03/2024.
//

import SwiftUI

struct TransactionDetailsView: View {

    let transaction: Transaction

    var body: some View {
        ZStack {
            Color.primaryBackground
                .ignoresSafeArea()

            VStack(spacing: 20) {
                partnerView
                descriptionView
            }
        }
    }

    @ViewBuilder
    private var partnerView: some View {
        VStack {
            Text("Partner:",
                 comment: "Header for partner name on transaction details screen")
            .fontWeight(.light)
            .foregroundStyle(.primaryFont.secondary)

            Text(transaction.partnerDisplayName)
                .foregroundStyle(.primaryFont)
        }
    }

    @ViewBuilder
    private var descriptionView: some View {
        if let description = transaction.transactionDetail.description {
            VStack {
                Text("Description:",
                     comment: "Header for description on transaction details screen")
                .fontWeight(.light)
                .foregroundStyle(.primaryFont.secondary)

                Text(description)
                    .foregroundStyle(.primaryFont)
            }
        }
    }
}

#Preview {
    TransactionDetailsView(transaction: .mock)
}

