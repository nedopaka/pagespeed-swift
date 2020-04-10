//
//  WelcomeViewController.swift
//  PageSpeed
//
//  Created by Alex on 4/10/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBAction private func nextButtonTap(_ sender: Any) {
        let rootViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "MainTabBarController") as MainTabBarController
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.window?.rootViewController = rootViewController
    }
}
