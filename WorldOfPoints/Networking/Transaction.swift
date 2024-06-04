//
//  Transaction.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 29/03/2024.
//

import Foundation

struct TransactionsResponse: Decodable {
    let items: [Transaction]
}

struct Transaction: Decodable, Identifiable, Equatable, Hashable {

    struct Alias: Decodable, Equatable, Hashable  {
        let reference: String
    }

    struct Detail: Decodable, Equatable, Hashable  {
        struct Value: Decodable, Equatable, Hashable  {
            let amount: Int
            let currency: String
        }

        let description: String?
        let bookingDate: Date
        let value: Value
    }

    let alias: Alias
    let partnerDisplayName: String
    let category: Int
    let transactionDetail: Detail

    var id: String {
        alias.reference
    }
//
//    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
//        lhs.id == rhs.id
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
}
