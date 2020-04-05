//
//  ArrayHelpers.swift
//  PageSpeed
//
//  Created by Alex on 4/4/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    mutating func addItemIfNotExist(_ item: Element) {
        if !contains(item) {
            append(item)
        }
    }

    mutating func removeItemIfExist(_ item: Element) {
        while contains(item) {
            if let index = self.firstIndex(of: item) {
                remove(at: index)
            }
        }
    }
}
