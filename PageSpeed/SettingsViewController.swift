//
//  SettingsViewController.swift
//  
//
//  Created by Ilya on 10.04.2020.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet private weak var clearHistoryButton: UIButton!

    @IBAction private func clearHistoryAction(_ sender: Any) {
        DBManager.sharedInstance?.deleleHistory()
    }
}
