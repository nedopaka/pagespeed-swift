//
//  TestResultsViewController.swift
//  PageSpeed
//
//  Created by Alex on 2/16/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

class TestResultsViewController: UIViewController {

    // MARK: - Properties
    var url: String?
    var mobilePageSpeedResult, desktopPageSpeedResult: PageSpeedResponse?
    var servicesArr: [
    (id: String, name: String)
    ]?
    var gtmResponse: GTMTestStatusResponse?
    // MARK: - IBOutlets
    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var testResultsTableView: UITableView!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url {
            urlLabel.text = "URL: \(url)"
        }
        testResultsTableView.alwaysBounceVertical = false
    }

    override func viewDidLayoutSubviews() {
        var frame = testResultsTableView.frame
        frame.size.height = testResultsTableView.contentSize.height
        testResultsTableView.frame = frame
    }
}

// MARK: - UITableViewDataSource
extension TestResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        servicesArr?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = testResultsTableView.dequeueReusableCell(withIdentifier: "TestResultsCell", for: indexPath)

        cell.textLabel?.text = servicesArr?[indexPath.row].name
        cell.detailTextLabel?.text = getServiceTestOverallResult(id: servicesArr?[indexPath.row].id ?? "")
        return cell
    }

    func getServiceTestOverallResult(id: String) -> String {
        switch id {
        case "pagespeed":
            var mobileScore = ""
            var desktopScore = ""
            if let mobileResult = mobilePageSpeedResult {
                let score = mobileResult.lighthouseResult.categories.performance.score * 100
                mobileScore = "Mobile Overall Score: \(Int(score))"
            }
            if let desktopResult = desktopPageSpeedResult {
                let score = desktopResult.lighthouseResult.categories.performance.score * 100
                desktopScore = "Desktop Overall Score: \(Int(score))"
            }
            return "\(mobileScore) \(desktopScore)"
        case "gtmetrix":
            let score = gtmResponse?.results?.pageSpeedScore ?? 0
            return "Page Speed Score: \(score)"
        default:
            return ""
        }
    }
}

extension TestResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = servicesArr?[indexPath.row].id {
            switch id {
            case "pagespeed":
                break
            case "gtmetrix":
                let controller: GTMResaultViewController? = UIStoryboard(
                    name: "Stage-B",
                    bundle: nil
                ).instantiateViewController(identifier: "GTMResaultViewController")
                    as? GTMResaultViewController
                controller?.response = self.gtmResponse
                self.navigationController?.pushViewController(controller!, animated: true)
            default:
                break
            }
        }
    }
}
