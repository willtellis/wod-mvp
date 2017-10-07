//
//  Reducer.swift
//  WODmvp
//
//  Created by Will Ellis on 10/5/17.
//  Copyright © 2017 Will Ellis Inc. All rights reserved.
//

import ReSwift

// the reducer is responsible for evolving the application state based
// on the actions it receives
func reducer(action: Action, state: AppState?) -> AppState {
    // if no state has been provided, create the default state
    var state = state ?? AppState()

    switch action {
    // TODO: WTE - case _ as MyAction:
    default:
        break
    }

    return state
}
