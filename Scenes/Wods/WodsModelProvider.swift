//
//  WodsModelProvider.swift
//  WODmvp
//
//  Created by Will Ellis on 10/8/17.
//  Copyright © 2017 Will Ellis Inc. All rights reserved.
//

import Foundation
import ReSwift

extension WodState {
    init(_ wod: Wod) {
        name = wod.name
        content = wod.content
    }
}

enum WodsError: Error {
    case networkError
}

struct WodsModel {
    var wods: Request<[WodState]>

    init(wods: Request<[WodState]> = .notStarted) {
        self.wods = wods
    }

    init(_ state: AppState) {
        guard case .initialized(let browsingState) = state.initialization else {
            self.init()
            return
        }
        self.init(
            wods: browsingState.wods
        )
    }
}

protocol WodsModelSubscriber: AnyObject {
    func update(_ model: WodsModel)
}

class WodsModelProvider: StoreSubscriber {
    private let store: AppStore
    private let dataService: DataServiceType

    init(_ store: AppStore = AppStore.main, _ dataService: DataServiceType = DataService.main) {
        self.store = store
        self.dataService = dataService
    }

    weak var subscriber: WodsModelSubscriber? {
        didSet {
            store.unsubscribe(self)
            store.subscribe(self)
        }
    }

    func loadModel() {
        DataService.main.getWods { result in
            let wodsState: Request<[WodState]>
            switch result {
            case .success(let value):
                wodsState = Request.success(value.map { WodState($0) })
            case .failure:
                wodsState = Request.failure(WodsError.networkError)
            }
            AppStore.main.dispatch(WodsAction.updateWods(wodsState))
        }
    }

    // MARK: StoreSubscriber
    typealias StoreSubscriberStateType = AppState

    func newState(state: AppState) {
        subscriber?.update(WodsModel(state))
    }
}
