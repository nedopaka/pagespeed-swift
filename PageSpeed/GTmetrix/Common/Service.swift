//
//  Service.swift
//  PageSpeed
//
//  Created by Ilya on 10.02.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Foundation

/// Protocol for async services implementation 
protocol Service: class {
    var identifier: String { get set }
}

extension Service {

    func generate() {
        if identifier.isEmpty {
            identifier = UUID().uuidString
        }
    }

    func started() {
        ServicesManager.manager.add(service: self)
    }

    func finished() {
        ServicesManager.manager.remove(service: self)
    }
}
