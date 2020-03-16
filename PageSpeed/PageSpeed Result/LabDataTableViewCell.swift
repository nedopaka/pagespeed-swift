//
//  LabDataTableViewCell.swift
//  PageSpeed
//
//  Created by Alex on 3/4/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

class LabDataTableViewCell: UITableViewCell {

    // MARK: - Properties

    var id: PageSpeedLabData?
    var labDataTitle: String {
        get {
            labDataTitleLabel.text ?? ""
        }
        set {
            labDataTitleLabel.text = newValue
        }
    }
    var labDataDescription: NSAttributedString {
        get {
            labDataDescriptionTextView.attributedText
        }
        set {
            labDataDescriptionTextView.attributedText = newValue
        }
    }
    var labDataResult: String {
        get {
            labDataResultLabel.text ?? ""
        }
        set {
            labDataResultLabel.text = newValue
        }
    }
    var labDataScore: Double?
    var showDescription: Bool {
        get {
            labDataDescriptionTextView.isHidden
        }
        set {
            labDataDescriptionTextView.isHidden = newValue
        }
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var labDataIcon: UIView!
    @IBOutlet private weak var labDataTitleLabel: UILabel!
    @IBOutlet private weak var labDataDescriptionTextView: UITextView!
    @IBOutlet private weak var labDataResultLabel: UILabel!

    // MARK: - Methods

    func configureCell() {
        labDataIcon.makeRectangular()
        labDataIcon.backgroundColor = .systemBackground
        labDataIcon.removeSublayers()
        switch (labDataScore ?? 0) * 100 {
        case 75...100:
            labDataIcon.addCircleLayer(fillColor: UIColor(named: "PageSpeedFastColor")!.cgColor)
            labDataResultLabel.textColor = UIColor(named: "PageSpeedFastSecondaryColor")
        case 50...74:
            labDataIcon.addRectangleLayer(fillColor: UIColor(named: "PageSpeedAverageColor")!.cgColor)
            labDataResultLabel.textColor = UIColor(named: "PageSpeedAverageSecondaryColor")
        case 0...49:
            labDataIcon.addTriangleLayer(fillColor: UIColor(named: "PageSpeedSlowColor")!.cgColor)
            labDataResultLabel.textColor = UIColor(named: "PageSpeedSlowSecondaryColor")
        default:
            return
        }
    }
}
