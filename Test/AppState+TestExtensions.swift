//
//  AppState+TestExtensions.swift
//  WODmvp
//
//  Created by Will Ellis on 10/7/17.
//  Copyright © 2017 Will Ellis Inc. All rights reserved.
//

import Foundation

extension AppState {
    static let test: AppState = {
        let browsingState = BrowsingState(
            wods: [WodState(name: "Endurence Warmup", content: "3 rounds of 1:00 each samson stretch, air squat, ring row, push up, good morning, sit up")]
        )
        return AppState(
            initialization: .initialized(browsingState)
        )
    }()
}
