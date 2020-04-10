//
//  MainViewController.swift
//  PageSpeed
//
//  Created by Alex on 12/29/19.
//  Copyright © 2019 Stanford University. All rights reserved.
//

import UIKit
import Moya

// MARK: - MainTabBarController

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let newTestViewController = UIStoryboard(name: "Stage-A", bundle: nil)
            .instantiateViewController(identifier: "NewTestViewController")
            as? NewTestViewController
        let historyViewController = UIStoryboard(name: "Stage-B", bundle: nil)
        .instantiateViewController(identifier: "HistoryTableViewController")
        let supportViewController = UIStoryboard(name: "Stage-B", bundle: nil)
        .instantiateViewController(identifier: "SupportViewController")
        let settingsViewController = UIStoryboard(name: "Stage-B", bundle: nil)
        .instantiateViewController(identifier: "SettingsViewController")

        let controllers = [newTestViewController, historyViewController, supportViewController, settingsViewController]
        var index = 0

        _ = viewControllers?.map {
            ($0 as? UINavigationController)?.setViewControllers([controllers[index]!], animated: false)
            index += 1
        }
    }
}

// MARK: - MainViewController

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
