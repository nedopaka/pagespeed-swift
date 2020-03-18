//
//  HistoryCellDelegate.swift
//  PageSpeed
//
//  Created by Admin on 18.03.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Foundation

enum TestType {
    case gTMetrix
    case pageSpeed
}

protocol HistoryCellDelegate {
    var title: String { get }
    var subTitle: String { get }
    var testType: TestType { get }
}
