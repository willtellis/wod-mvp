//
//  ClassNameIdentifiable.swift
//  WODmvp
//
//  Created by Will Ellis on 10/6/17.
//  Copyright © 2017 Will Ellis Inc. All rights reserved.
//

import Foundation
import UIKit

public protocol ClassNameIdentifiable {
    static var reusableIdentifier: String { get }
}

extension ClassNameIdentifiable where Self: UITableViewCell {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
