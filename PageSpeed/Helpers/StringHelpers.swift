//
//  StringHelpers.swift
//  PageSpeed
//
//  Created by Alex on 2/5/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

extension String {
    var isValidURL: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
}
