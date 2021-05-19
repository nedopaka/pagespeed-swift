//
//  UIViewControllerHelpers.swift
//  PageSpeed
//
//  Created by Alex on 4/1/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlert(
        title: String,
        message: String,
        options: String...,
        completion: @escaping (Int) -> Void
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        for (index, option) in options.enumerated() {
            alertController.addAction(
                UIAlertAction(title: option, style: .default) { action in
                    DispatchQueue.main.async {
                        completion(index)
                        print("\(action) triggered")
                    }
                }
            )
        }
        let currentViewController = topMostViewController()
        if (currentViewController as? UIAlertController) == nil {
            currentViewController.present(alertController, animated: true, completion: nil)
        } else {
            debugPrint("UIAlertController is already on screen")
        }
    }

    func topMostViewController() -> UIViewController {
        var topViewController = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController
        while topViewController?.presentedViewController != nil {
            topViewController = topViewController?.presentedViewController
        }
        return topViewController!
    }

    func endEditingOnFocusOut() {
        let tap = UITapGestureRecognizer(
            target: view,
            action: #selector(view.endEditing)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
