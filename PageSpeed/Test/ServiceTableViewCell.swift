//
//  ServiceTableViewCell.swift
//  PageSpeed
//
//  Created by Alex on 2/15/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    // MARK: - Properties

    var id: String = ""

    var displayName: String {
        get {
            nameLabel.text ?? ""
        }
        set {
            nameLabel.text = newValue
        }
    }

    var serviceEnabled: Bool {
        get {
            serviceSwitch.isOn
        }
        set {
            serviceSwitch.isOn = newValue
        }
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var serviceSwitch: UISwitch!

    // MARK: - IBActions
    @IBAction private func serviceSwitchValueChanged(_ sender: Any) {

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
