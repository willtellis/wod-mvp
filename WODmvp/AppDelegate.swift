//
//  AppDelegate.swift
//  WODmvp
//
//  Created by Will Ellis on 9/21/17.
//  Copyright © 2017 Will Ellis Inc. All rights reserved.
//

import UIKit
import ReSwift

// The global application store, which is responsible for managing the appliction state.
extension Store where State == AppState {
    static let main = Store<AppState>(reducer: reducer, state: AppState.test)
}
typealias AppStore = Store<AppState>

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

