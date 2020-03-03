//
//  GTMResaultViewController.swift
//  PageSpeed
//
//  Created by Admin on 19.02.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

class GTMetrixResaultViewController: UITableViewController {

    @IBOutlet private weak  var imageScreenShot: UIImageView!
    @IBOutlet private weak var labelPageTitle: UILabel!
    @IBOutlet private weak var labelPageSpeedScore: UILabel!
    @IBOutlet private weak var labelYSlowScore: UILabel!
    @IBOutlet private weak var labelFullyLoadedTime: UILabel!
    @IBOutlet private weak var labelTotalPageSize: UILabel!
    @IBOutlet private weak var labelRequests: UILabel!
    var response: GTMetrixTestStatusResponse? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        if let response = response {
            // labelPageTitle.text = response.resources
            labelPageSpeedScore?.text = "\(response.results?.pageSpeedScore ?? 0)"
            labelYSlowScore?.text = "\(response.results?.yslowScore ?? 0)"
            labelFullyLoadedTime?.text = "\(response.results?.fullyLoadedTime ?? 0)"
            labelTotalPageSize?.text = "\(response.results?.pageBytes ?? 0)"
            labelRequests?.text = "\(response.results?.pageElements ?? 0)"
            print(response)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
}
