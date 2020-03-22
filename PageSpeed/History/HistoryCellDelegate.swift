//
//  HistoryCellDelegate.swift
//  PageSpeed
//
//  Created by Ilya on 18.03.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Foundation

enum TestType {
    case gtMetrix
    case pageSpeed
}

/// Protocol for history cell
protocol HistoryCellDelegate: class {
    var title: String { get }
    var subTitle: String { get }
    var testType: TestType { get }
}
