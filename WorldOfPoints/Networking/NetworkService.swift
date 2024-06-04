//
//  NetworkService.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 29/03/2024.
//

import Combine
import Foundation

protocol NetworkServiceProtocol {
    func getTransactions() async throws -> [Transaction]
    var isNetworkReachable: Bool { get }
    var networkReachablePublisher: AnyPublisher<Bool, Never> { get }
}
