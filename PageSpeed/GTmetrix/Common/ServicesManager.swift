//
//  ServicesManager.swift
//  PageSpeed
//
//  Created by Admin on 10.02.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Foundation

// класс для хранения экземпляров сервисов, на время выполнения
class ServicesManager {
    static let manager = ServicesManager()
    private var services: [String: Service]
    fileprivate init() {
        services = [:]
    }

    func add(service: Service) {
        if service.identifier.isEmpty {
            return
        }
        services[service.identifier] = service
    }

    func remove(service: Service) {
        if service.identifier.isEmpty {
            return
        }
        services[service.identifier] = nil
    }
}
