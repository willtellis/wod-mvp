//
//  AppState.swift
//  WODmvp
//
//  Created by Will Ellis on 10/5/17.
//  Copyright © 2017 Will Ellis Inc. All rights reserved.
//

import ReSwift

enum Request<T> {
    case notStarted
    case loading
    case success(T)
    case failure(Error)
}

struct AppState: StateType {
    var initialization: Initialization = .uninitialized
}

enum Initialization {
    case uninitialized
    case initialized(BrowsingState)
}

struct BrowsingState {
    var wods: Request<[WodState]> = .notStarted
}

struct WodState {
    var name: String
    var content: String
}
