//
//  Sequence+Extensions.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 29/03/2024.
//

import Foundation

extension Sequence {
    public func sorted<T: Comparable>(
        by keyPath: KeyPath<Element, T>,
        ascending: Bool = true
    ) -> [Element] {
        sorted { left, right in
            if ascending {
                left[keyPath: keyPath] < right[keyPath: keyPath]
            } else {
                left[keyPath: keyPath] > right[keyPath: keyPath]
            }
        }
    }

    public func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        map { $0[keyPath: keyPath] }
    }
}
