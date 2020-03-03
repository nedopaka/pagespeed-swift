//
//  CustomError.swift
//  PageSpeed
//
//  Created by Admin on 10.02.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case custom(error: String)
    var localizedDescription: String {
        switch self {
        case .custom(let error):
            return error
        }
    }
}
