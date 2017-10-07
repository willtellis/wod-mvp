//
//  WodsPresenter.swift
//  WODmvp
//
//  Created by Will Ellis on 10/7/17.
//  Copyright © 2017 Will Ellis Inc. All rights reserved.
//

import Foundation
import ReSwift

struct WodCellViewModel {
    var title: String = ""
    var content: String = ""
}

struct WodsViewModel {
    let title: String
    let wodCellViewModels: [WodCellViewModel]

    init(
        title: String = "",
        wodCellViewModels: [WodCellViewModel] = []
    ) {
        self.title = title
        self.wodCellViewModels = wodCellViewModels
    }

    init(_ state: AppState) {
        guard case .initialized(let browsingState) = state.initialization else {
            self.init()
            return
        }
        self.init(
            title: NSLocalizedString("Wods", comment: ""),
            wodCellViewModels: browsingState.wods.map {
                WodCellViewModel(title: $0.name, content: $0.content)
            }
        )
    }
}

protocol WodsView: AnyObject {
    func render(_ viewModel: WodsViewModel)
}

class WodsPresenter: StoreSubscriber {
    let store: AppStore
    
    weak var view: WodsView? {
        didSet {
            store.unsubscribe(self)
            store.subscribe(self)
        }
    }

    init(_ store: AppStore = AppStore.main) {
        self.store = store
    }

    func presentWodDetails(for wodIndex: Int) {
        // TODO: WTE
    }

    // Mark: StoreSubscriber
    typealias StoreSubscriberStateType = AppState

    func newState(state: AppState) {
        view?.render(WodsViewModel(state))
    }
}
