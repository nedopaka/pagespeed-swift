//
//  PageSpeedHistoryListViewController.swift
//  PageSpeed
//
//  Created by Alex on 3/27/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit
import Realm

class PageSpeedHistoryListViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var historyTableView: UITableView!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self as UITableViewDelegate
        historyTableView.dataSource = self as UITableViewDataSource
        let data = (NSDataAsset(name: "Google logo")?.data)!
        let img = UIImage(data: data)
        headerImageView.image = img
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        historyTableView.reloadData()
        let url = URL(string: "https://weblab.gr/wp-content/uploads/2017/06/google.gif")
        headerImageView.kf.setImage(with: url)
    }
}

// MARK: - UITableViewDataSource
extension PageSpeedHistoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DBManager.sharedInstance?.getPageSpeedV5Items().count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "History Data"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "PageSpeedHistoryItemCell", for: indexPath)
        let item = DBManager.sharedInstance?.getPageSpeedV5Items() [indexPath.row]
        cell.textLabel?.text = "\(item?.url ?? "") - \(item?.strategy ?? "")"
        cell.detailTextLabel?.text = "Date: \(item?.analysisUTCTimestamp.convertFormatedStringToFormatedDate() ?? "")"
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PageSpeedHistoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pageSpeedHistoryItemViewController = UIStoryboard(name: "PageSpeedHistory", bundle: nil)
            .instantiateViewController(identifier: "PageSpeedHistoryItemViewController")
            as PageSpeedHistoryItemViewController
        let item = DBManager.sharedInstance?.getPageSpeedV5Items() [indexPath.row]
        pageSpeedHistoryItemViewController.pageSpeedV5Item = item
        navigationController?.pushViewController(pageSpeedHistoryItemViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
}
