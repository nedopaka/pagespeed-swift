//
//  Service.swift
//  PageSpeed
//
//  Created by Admin on 10.02.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Foundation

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
