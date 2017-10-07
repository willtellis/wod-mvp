//
//  AppState.swift
//  WODmvp
//
//  Created by Will Ellis on 10/5/17.
//  Copyright © 2017 Will Ellis Inc. All rights reserved.
//

import ReSwift

struct AppState: StateType {
    var initialization: Initialization = .uninitialized
}

enum Initialization {
    case uninitialized
    case initialized(BrowsingState)
}

struct BrowsingState {
    var wods: [WodState] = []
}

struct WodState {
    var name: String
    var content: String
}
