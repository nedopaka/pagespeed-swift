//
//  GTMetrixResultViewController.swift
//  PageSpeed
//
//  Created by Ilya on 19.02.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit
import UICircularProgressRing
import QuickLook

class GTMetrixResultViewController: UITableViewController {

    var urlPDF: URL?
    var response: GTMetrixResponseItem? {
        didSet {
            updateUI()
        }
    }
    @IBOutlet private weak var screenShotImage: UIImageView!
    @IBOutlet private weak var pageTitleLabel: UILabel!
    @IBOutlet private weak var fullyLoadedTimeLabel: UILabel!
    @IBOutlet private weak var totalPageSizeLabel: UILabel!
    @IBOutlet private weak var requestsLabel: UILabel!
    @IBOutlet private weak var htmlLoadTimeLabel: UILabel!
    @IBOutlet private weak var pageLoadTimeLabel: UILabel!
    @IBOutlet private weak var pageBytesLabel: UILabel!
    @IBOutlet private weak var htmlBytesLabel: UILabel!
    @IBOutlet private weak var pageElementsLabel: UILabel!
    @IBOutlet private weak var rumSpeedIndexLabel: UILabel!
    @IBOutlet private weak var loadPFDButton: UIButton!
    @IBOutlet private weak var gtMetrixScoreLabel: UICircularProgressRing!
    @IBOutlet private weak var gtMetrixYSlowScoreRing: UICircularProgressRing!
    @IBOutlet private weak var loadPDFActivity: UIActivityIndicatorView!

    @IBAction private func viewPDFButton(_ sender: UIButton) {
        if urlPDF == nil {
            loadPFDButton.isEnabled = false
            loadPDFActivity.startAnimating()
            GTMetrixResourceService(
                testID: response?.id ?? "",
                resource: .reportPdf
            ).run { [weak self] _, data, error in
                self?.loadPFDButton.isEnabled = true
                self?.loadPDFActivity.stopAnimating()
                if let data = data {
                    let fileName = NSUUID().uuidString + ".pdf"
                    let path = (NSTemporaryDirectory() as NSString).appendingPathComponent(fileName)
                    do {
                        let url = URL(fileURLWithPath: path)
                        try data.write(to: url)
                        self?.urlPDF = url
                        self?.openPDF()
                    } catch {
                        print(error)
                    }
                }
            }
        } else {
            openPDF()
        }
    }

    private func openPDF() {
        if urlPDF != nil {
            let previewController = QLPreviewController()
            previewController.dataSource = self
            present(previewController, animated: true) {
            }
        }
    }

    private func updateUI() {
        if let response = response {
            fullyLoadedTimeLabel?.text = "\((response.results?.fullyLoadedTime ?? 0) / 1_000) Sec"
            totalPageSizeLabel?.text = "\((response.results?.pageBytes ?? 0) / 1_024) KB"
            requestsLabel?.text = "\(response.results?.pageElements ?? 0)"
            htmlLoadTimeLabel?.text = "\(response.results?.htmlLoadTime ?? 0) ms"
            pageBytesLabel?.text = "\(response.results?.pageBytes ?? 0)"
            pageLoadTimeLabel?.text = "\(response.results?.onloadTime ?? 0) ms"
            htmlBytesLabel?.text = "\(response.results?.htmlBytes ?? 0)"
            pageElementsLabel?.text = "\(response.results?.pageElements ?? 0)"
            rumSpeedIndexLabel?.text = "\(response.results?.rumSpeedIndex ?? 0)"
            print(response)
            pageTitleLabel?.text = response.url
            GTMetrixResourceService(testID: response.id ?? "", resource: .screenshot).run { [weak self] image, _, _ in
                if let image = image {
                    self?.screenShotImage?.image = image
                }
            }
        }
    }

    func updateRing() {
        gtMetrixScoreLabel.maxValue = 100
        gtMetrixScoreLabel.delegate = self
        gtMetrixScoreLabel.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        gtMetrixScoreLabel.innerRingWidth = 10
        gtMetrixScoreLabel.outerRingWidth = 5
        gtMetrixYSlowScoreRing.maxValue = 100
        gtMetrixYSlowScoreRing.delegate = self
        gtMetrixYSlowScoreRing.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        gtMetrixYSlowScoreRing.innerRingWidth = 10
        gtMetrixYSlowScoreRing.outerRingWidth = 5
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateRing()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gtMetrixScoreLabel?.startProgress(to: CGFloat(response?.results?.pageSpeedScore ?? 0),
                                          duration: 2.0, completion: {
        })
        gtMetrixYSlowScoreRing?.startProgress(to: CGFloat(response?.results?.yslowScore ?? 0),
                                              duration: 2.0, completion: {
        })
    }

    func animateColorChange(ring: UICircularProgressRing, color: UIColor) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [.curveEaseOut],
            animations: {
                ring.innerRingColor = color
                ring.outerRingColor = .blue
                ring.fontColor = color
            })
    }
}

extension GTMetrixResultViewController: UICircularProgressRingDelegate {

    func didFinishProgress(for ring: UICircularProgressRing) {
    }

    func didPauseProgress(for ring: UICircularProgressRing) {
    }

    func didContinueProgress(for ring: UICircularProgressRing) {
    }

    func didUpdateProgressValue(for ring: UICircularProgressRing, to newValue: CGFloat) {
        switch Int(ring.currentValue ?? 0) {
        case 0...49:
            animateColorChange(ring: ring, color: .orange)//UIColor(named: "PageSpeedSlowColor")!)
        case 50...89:
            animateColorChange(ring: ring, color: .yellow)//UIColor(named: "PageSpeedAverageColor")!)
        case 90...100:
            animateColorChange(ring: ring, color: .green)//UIColor(named: "PageSpeedFastColor")!)
        default:
            return
        }
    }

    func willDisplayLabel(for ring: UICircularProgressRing, _ label: UILabel) {
    }
}

// MARK: - QLPreviewControllerDataSource
extension GTMetrixResultViewController: QLPreviewControllerDataSource {

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return urlPDF == nil ? 0 : 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return (urlPDF == nil ? URL(fileURLWithPath: "") : urlPDF!) as QLPreviewItem
    }
}
