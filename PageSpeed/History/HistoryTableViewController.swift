//
//  HistoryTableViewController.swift
//  PageSpeed
//
//  Created by Ilya on 19.03.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let pageSpeedHistoryListViewController = UIStoryboard(name: "PageSpeedHistory", bundle: nil)
                .instantiateViewController(identifier: "PageSpeedHistoryListViewController")
            navigationController?.pushViewController(pageSpeedHistoryListViewController, animated: true)
        }
    }
}
