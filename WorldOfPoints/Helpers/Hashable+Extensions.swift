//
//  Hashable+Extensions.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 29/03/2024.
//

import Foundation

extension Array where Element: Hashable {
    var unique: Self {
        Array(Set(self))
    }
}
