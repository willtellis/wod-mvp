//
//  Reducer.swift
//  WODmvp
//
//  Created by Will Ellis on 10/5/17.
//  Copyright © 2017 Will Ellis Inc. All rights reserved.
//

import ReSwift

enum InitializationAction: Action {
    case initialize
}

enum WodsAction: Action {
    case updateWods(Request<[WodState]>)
}

// the reducer is responsible for evolving the application state based
// on the actions it receives
func reducer(action: Action, state: AppState?) -> AppState {
    // if no state has been provided, create the default state
    var state = state ?? AppState()

    switch action {
    case let initializationAction as InitializationAction:
        state = initializationReducer(action: initializationAction, state: state)
    case let wodsAction as WodsAction:
        state = wodsReducer(action: wodsAction, state: state)
    default:
        break
    }

    return state
}

func initializationReducer(action: InitializationAction, state: AppState) -> AppState {
    var state = state
    switch action {
    case .initialize:
        state.initialization = .initialized(BrowsingState())
    }
    return state
}

func wodsReducer(action: WodsAction, state: AppState) -> AppState {
    guard case .initialized(var browsingState) = state.initialization else {
        return state
    }

    var state = state
    switch action {
    case .updateWods(let wods):
        browsingState.wods = wods
    }
    state.initialization = .initialized(browsingState)
    return state
}
