//
//  Preview+Helpers.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 30/03/2024.
//

import Foundation

var isRunningForPreviews: Bool {
    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}
