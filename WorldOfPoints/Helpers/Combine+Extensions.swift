//
//  Combine+Extensions.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 05/04/2024.
//

import Combine
import Foundation

extension Publisher {
    func receiveOnMainThread() -> Publishers.ReceiveOn<Self, DispatchQueue> {
        receive(on: DispatchQueue.main)
    }
}

public extension Publisher where Failure == Never {
    func weakAssign<T: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<T, Output>,
        on object: T
    ) -> AnyCancellable {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
