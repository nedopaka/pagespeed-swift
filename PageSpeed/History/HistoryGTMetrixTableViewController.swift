//
//  HistoryTableViewController.swift
//  PageSpeed
//
//  Created by Admin on 18.03.2020.
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
        //    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        // Configure the cell...
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
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
