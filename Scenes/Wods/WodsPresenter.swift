//
//  WodsPresenter.swift
//  WODmvp
//
//  Created by Will Ellis on 10/7/17.
//  Copyright © 2017 Will Ellis Inc. All rights reserved.
//

import Foundation

enum LoadingViewModel<T> {
    case loading
    case success(T)
    case failure(String)
}

extension LoadingViewModel where T == [WodCellViewModel] {
    init(_ wods: Request<[WodState]>) {
        switch wods {
        case .notStarted, .loading:
            self = .loading
        case .success(let wods):
            self = .success(wods.map {
                WodCellViewModel(title: $0.name, content: $0.content)
            })
        case .failure(let error):
            self = .failure(error.localizedDescription)
        }
    }
}

struct WodCellViewModel {
    var title: String = ""
    var content: String = ""
}

struct WodsViewModel {
    let title: String
    let wodCellViewModels: LoadingViewModel<[WodCellViewModel]>

    init(
        title: String = "",
        wodCellViewModels: LoadingViewModel<[WodCellViewModel]> = .loading
    ) {
        self.title = title
        self.wodCellViewModels = wodCellViewModels
    }

    init(_ model: WodsModel) {
        self.init(
            title: NSLocalizedString("Wods", comment: ""),
            wodCellViewModels: LoadingViewModel(model.wods)
        )
    }
}

protocol WodsView: AnyObject {
    func render(_ viewModel: WodsViewModel)
}

class WodsPresenter: WodsModelSubscriber {
    private let modelProvider: WodsModelProviderType
    weak var view: WodsView? {
        didSet {
            modelProvider.subscriber = (view != nil) ? self : nil
        }
    }

    init(_ modelProvider: WodsModelProviderType = WodsModelProvider()) {
        self.modelProvider = modelProvider
    }

    func presentWodDetails(for wodIndex: Int) {
        // TODO: WTE
    }

    // MARK: WodsModelSubscriber
    func update(_ model: WodsModel) {
        view?.render(WodsViewModel(model))
        if case .notStarted = model.wods {
            modelProvider.loadModel()
        }
    }
}
