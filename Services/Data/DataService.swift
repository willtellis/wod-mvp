//
//  DataService.swift
//  WODmvp
//
//  Created by Will Ellis on 10/7/17.
//  Copyright © 2017 Will Ellis Inc. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure
}

struct Wod {
    var name: String
    var content: String
}

protocol DataServiceType {
    func getWods(_ completion: @escaping (Result<[Wod]>) -> Void)
}

struct DataService: DataServiceType {
    static let main = DataService()

    func getWods(_ completion: @escaping (Result<[Wod]>) -> Void) {
        DispatchQueue.global(qos: .userInitiated) .async {
            sleep(2)
            DispatchQueue.main.async {
                completion(.success(DataService.testWods))
            }
        }
    }
}

extension DataService {
    static let testWods: [Wod] = {
        return [Wod(name: "Endurence Warmup", content: "3 rounds of 1:00 each samson stretch, air squat, ring row, push up, good morning, sit up")]
    }()
}
