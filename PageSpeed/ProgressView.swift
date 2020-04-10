//
//  ProgressView.swift
//  PageSpeed
//
//  Created by Ilya on 10.04.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Processing"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    var largeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please wait"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 40, weight: .light)

        return label
    }()
    var backGroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.9
        view.backgroundColor = .lightGray
        return view
    }()

    var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 8
        return view
    }()

    override func didMoveToSuperview() {
        guard let superview = superview
            else { return }
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        addSubview(backGroundView)
        leftAnchor.constraint(equalTo: backGroundView.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: backGroundView.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: backGroundView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: backGroundView.bottomAnchor).isActive = true
        stackView.addArrangedSubview(activityIndicator)
        stackView.addArrangedSubview(titleLabel)
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 300).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        addSubview(largeTitleLabel)
        largeTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        largeTitleLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        activityIndicator.startAnimating()
    }
}
