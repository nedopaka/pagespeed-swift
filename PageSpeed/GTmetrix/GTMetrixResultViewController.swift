//
//  GTMetrixResaultViewController.swift
//  PageSpeed
//
//  Created by Admin on 19.02.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit
import UICircularProgressRing
import QuickLook

class GTMetrixResultViewController: UITableViewController {

    @IBOutlet private weak var screenShotImage: UIImageView!
    @IBOutlet private weak var pageTitleLabel: UILabel!
    @IBOutlet private weak var ringGTMetrixScore: UICircularProgressRing!
    @IBOutlet private weak var ringGTMetrixYSlowScore: UICircularProgressRing!
    @IBOutlet private weak var labelFullyLoadedTime: UILabel!
    @IBOutlet private weak var labelTotalPageSize: UILabel!
    @IBOutlet private weak var labelRequests: UILabel!
    @IBOutlet private weak var labelHTMLLoadTime: UILabel!
    @IBOutlet private weak var labelPageLoadTime: UILabel!
    @IBOutlet private weak var labelPageBytes: UILabel!
    @IBOutlet private weak var labelHTMLBytes: UILabel!
    @IBOutlet private weak var labelPageElements: UILabel!
    @IBOutlet private weak var labelRumSpeedIndex: UILabel!
    @IBOutlet private weak var buttonLoadPFD: UIButton!
    @IBOutlet private weak var activityLoadPDF: UIActivityIndicatorView!
    var urlPDF: URL?
    var response: GTMetrixResponseItem? {
        didSet {
            updateUI()
        }
    }

    @IBAction private func viewPDFButton(_ sender: UIButton) {
        if urlPDF == nil {
            buttonLoadPFD.isEnabled = false
            activityLoadPDF.startAnimating()
            GTMetrixResourceService(
                testID: response?.id ?? "",
                resource: .reportPdf
            ).run { [weak self] _, data, error in
                self?.buttonLoadPFD.isEnabled = true
                self?.activityLoadPDF.stopAnimating()
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
            labelFullyLoadedTime?.text = "\((response.results?.fullyLoadedTime ?? 0) / 1000) Sec"
            labelTotalPageSize?.text = "\((response.results?.pageBytes ?? 0) / 1024) KB"
            labelRequests?.text = "\(response.results?.pageElements ?? 0)"
            labelHTMLLoadTime?.text = "\(response.results?.htmlLoadTime ?? 0) ms"
            labelPageBytes?.text = "\(response.results?.pageBytes ?? 0)"
            labelPageLoadTime?.text = "\(response.results?.onloadTime ?? 0) ms"
            labelHTMLBytes?.text = "\(response.results?.htmlBytes ?? 0)"
            labelPageElements?.text = "\(response.results?.pageElements ?? 0)"
            labelRumSpeedIndex?.text = "\(response.results?.rumSpeedIndex ?? 0)"
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
        ringGTMetrixScore.maxValue = 100
        ringGTMetrixScore.delegate = self
        ringGTMetrixScore.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        ringGTMetrixScore.innerRingWidth = 10
        ringGTMetrixScore.outerRingWidth = 5
        ringGTMetrixYSlowScore.maxValue = 100
        ringGTMetrixYSlowScore.delegate = self
        ringGTMetrixYSlowScore.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        ringGTMetrixYSlowScore.innerRingWidth = 10
        ringGTMetrixYSlowScore.outerRingWidth = 5
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateRing()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ringGTMetrixScore?.startProgress(to: CGFloat(response?.results?.pageSpeedScore ?? 0),
                                         duration: 2.0, completion: {
        })
        ringGTMetrixYSlowScore?.startProgress(to: CGFloat(response?.results?.yslowScore ?? 0),
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

extension GTMetrixResultViewController: QLPreviewControllerDataSource {

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return urlPDF == nil ? 0 : 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return (urlPDF == nil ? URL(fileURLWithPath: "") : urlPDF!) as QLPreviewItem
    }
}
