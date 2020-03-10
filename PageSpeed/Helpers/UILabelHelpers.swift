//
//  UILabelHelpers.swift
//  PageSpeed
//
//  Created by Alex on 3/7/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

extension UILabel {
    func animateCounter(startValue: Int, endValue: Int, withDuration: Int, trailingString: String = "") {
        DispatchQueue.global(qos: .userInteractive).async(execute: {
            for step in startValue...endValue {
                usleep(useconds_t(withDuration / endValue * 1_000_000))
                DispatchQueue.main.async(execute: {
                    self.text = "\(step)\(trailingString)"
                })
            }
        })
    }
}
