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
      fileprivate func test() {
            GTMTestURLService(url: "google.com").start { response, error in
                if let response = response {
    print(response)
                } else {
                    print(error?.localizedDescription)
                }
            }
        }


    override func viewDidLoad() {
        super.viewDidLoad()

        let newTestViewController = UIStoryboard(name: "Stage-A", bundle: nil)
            .instantiateViewController(identifier: "NewTestViewController")
            as? NewTestViewController
        let historyViewController = UIViewController()
        let supportViewController = UIViewController()
        let settingsViewController = UIViewController()

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
