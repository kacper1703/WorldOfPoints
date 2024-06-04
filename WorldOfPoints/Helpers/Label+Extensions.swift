//
//  Label+Extensions.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 29/03/2024.
//

import SFSymbols
import SwiftUI

extension Label where Title == Text, Icon == Image {
    public init(
        symbol: SFSymbol,
        @ViewBuilder title: () -> Title
    ) {
        self.init(
            title: title,
            icon: {
                Image(symbol: symbol)
            }
        )
    }
}
