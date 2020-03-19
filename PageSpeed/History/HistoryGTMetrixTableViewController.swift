//
//  HistoryGTMetrixTableViewController.swift
//  PageSpeed
//
//  Created by Ilya on 18.03.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryGTMetrixTableViewController: UITableViewController {
    var items: [HistoryCellDelegate] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadItems()
    }

    func loadItems() {
        items.removeAll()
        guard let dBManager = DBManager.sharedInstance else {
            return
        }
        if let gtMetrixItems: Results<GTMetrixResponseItem> = dBManager.getItems() {
            gtMetrixItems.forEach { [weak self] item in
                self?.items.append(item)
            }
        }
        tableView.reloadData()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        if let item = getItem(indexPath: indexPath) {
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = item.subTitle
        }
        return cell
    }

    func getItem(indexPath: IndexPath) -> HistoryCellDelegate? {
        if indexPath.row < items.count {
            return items[indexPath.row]
        }
        return nil
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = getItem(indexPath: indexPath) as? GTMetrixResponseItem,
            let resultController = UIStoryboard(name: "Stage-B", bundle: nil)
                .instantiateViewController(identifier: "GTMetrixResultViewController") as? GTMetrixResultViewController
            else {
                return
        }
        resultController.response = item
        navigationController?.pushViewController(resultController, animated: true)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "History Data"
    }
}
