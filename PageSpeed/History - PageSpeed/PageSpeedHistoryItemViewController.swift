//
//  PageSpeedHistoryItemViewController.swift
//  PageSpeed
//
//  Created by Alex on 3/28/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit
import UICircularProgressRing
import SwiftyMarkdown

class PageSpeedHistoryItemViewController: UIViewController {

    // MARK: - Properties

    private var viewShowed: Bool?
    var pageSpeedV5Item: PageSpeedV5Item?

    private var labDataTableViewHeight: CGFloat {
        labDataTableView.layoutIfNeeded()
        return labDataTableView.contentSize.height
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var showResultSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var strategyLabel: UILabel!

    // Result CircularProgressRing
    @IBOutlet private weak var overallResultCircularProgressRing: UICircularProgressRing!
    @IBOutlet private weak var overallResultLabel: UILabel!
    @IBOutlet private weak var overallResultCircularProgressRingCanvas: UIView!

    @IBOutlet private weak var mapResult: UIView!

    @IBOutlet private weak var fieldDataOverallCategory: UILabel!

    // FCP Chart
    @IBOutlet private weak var iconFCP: UIView!
    @IBOutlet private weak var timeFCPLabel: UILabel!
    @IBOutlet private weak var fastFCPChart: UIView!
    @IBOutlet private weak var fastFCPChartWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var fastFCPChartLabel: UILabel!

    @IBOutlet private weak var averageFCPChart: UIView!
    @IBOutlet private weak var averageFCPChartWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var averageFCPChartLabel: UILabel!

    @IBOutlet private weak var slowFCPChart: UIView!
    @IBOutlet private weak var slowFCPChartWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var slowFCPChartLabel: UILabel!

    // FID Chart
    @IBOutlet private weak var iconFID: UIView!
    @IBOutlet private weak var timeFIDLabel: UILabel!
    @IBOutlet private weak var fastFIDChart: UIView!
    @IBOutlet private weak var fastFIDChartWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var fastFIDChartLabel: UILabel!

    @IBOutlet private weak var averageFIDChart: UIView!
    @IBOutlet private weak var averageFIDChartWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var averageFIDChartLabel: UILabel!

    @IBOutlet private weak var slowFIDChart: UIView!
    @IBOutlet private weak var slowFIDChartWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var slowFIDChartLabel: UILabel!

    @IBOutlet private weak var finalScreenshotImageView: UIImageView!
    @IBOutlet private weak var labDataTableView: UITableView!
    @IBOutlet private weak var labDataTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var timestampTextView: UITextView!

    // MARK: - IBActions

    @IBAction private func changeResultView(_ sender: Any) {
        if (sender as? UISegmentedControl)?.selectedSegmentIndex == 0 {
            if let data = pageSpeedV5Item {
                // animation
                overallResultCircularProgressRing.startProgress(
                    to: CGFloat(data.performanceScore * 100), duration: 0.5
                ) {
                    print("Overall mobile score displayed")
                }
                showFieldDataOverallCategory(result: data)
                showResultDetails(result: data)
                // animation
                drawHorizontalMetricCharts(result: data, duration: 0.5)
                showFinalScreenshot(result: data)
            }
        }
        labDataTableView.reloadData()
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLayout()
        if let data = pageSpeedV5Item {
            urlLabel.text = data.url
            strategyLabel.attributedText = SwiftyMarkdown(
                string: "**Strategy:** " + data.strategy.capitalized
            ).attributedString()
            showFieldDataOverallCategory(result: data)
            showResultDetails(result: data)
            showFinalScreenshot(result: data)
        }
        mapResult.addTapGesture(
            numberOfTouchesRequired: 1,
            target: self,
            action: #selector(showPageSpeedInfoViewController)
        )
    }

    override func viewDidLayoutSubviews() {
        let labDataTableHeight = labDataTableViewHeight
        labDataTableViewHeightConstraint.constant = labDataTableHeight
        labDataTableView.layoutIfNeeded()
        labDataTableView.isScrollEnabled = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewShowed != nil { return }
        if let data = pageSpeedV5Item {
            // animation
            overallResultCircularProgressRing.startProgress(to: CGFloat(data.performanceScore * 100), duration: 1) {
                print("Overall mobile score displayed")
            }
            // animation
            drawHorizontalMetricCharts(result: data, duration: 0.5)
        }
        viewShowed = true
    }

    // MARK: - Methods

    @objc func showPageSpeedInfoViewController() {
        let pageSpeedInfoViewController = UIStoryboard(name: "Stage-A", bundle: nil)
            .instantiateViewController(identifier: "PageSpeedInfoViewController")
        navigationController?.pushViewController(pageSpeedInfoViewController, animated: true)
    }

    func prepareLayout() {
        overallResultCircularProgressRing.value = 0
        overallResultCircularProgressRing.maxValue = 100
        overallResultCircularProgressRing.delegate = self
        overallResultCircularProgressRingCanvas.makeCircular()

        fastFCPChartWidthConstraint.constant = 0
        averageFCPChartWidthConstraint.constant = 270
        slowFCPChartWidthConstraint.constant = 270
        fastFIDChartWidthConstraint.constant = 0
        averageFIDChartWidthConstraint.constant = 270
        slowFIDChartWidthConstraint.constant = 270

        iconFCP.makeRectangular()
        iconFCP.backgroundColor = .systemBackground
        iconFID.makeRectangular()
        iconFID.backgroundColor = .systemBackground
    }

    func showFieldDataOverallCategory(result: PageSpeedV5Item) {
        let color: UIColor?

        let category = result.overallCategory
        switch PageSpeedCategory(rawValue: category) {
        case .FAST:
            color = UIColor(named: "PageSpeedFastSecondaryColor")
        case .AVERAGE:
            color = UIColor(named: "PageSpeedAverageSecondaryColor")
        case .SLOW:
            color = UIColor(named: "PageSpeedSlowSecondaryColor")
        default:
            return
        }
        fieldDataOverallCategory.text = "\(category) speed".capitalized
        fieldDataOverallCategory.textColor = color
    }

    func showFinalScreenshot(result: PageSpeedV5Item) {
        let finalScreenshot = result.finalScreenshot.base64Convert()
        finalScreenshotImageView.image = finalScreenshot
    }

    func showResultDetails(result: PageSpeedV5Item) {
        showIconsForMetricResult(result: result)
        let fcpTimeInSec = Double(result.metrics?.percentileFCP ?? 0) / 1_000
        timeFCPLabel.text = "\(String(format: "%.2f", fcpTimeInSec)) s"
        timeFIDLabel.text = "\(result.metrics?.percentileFID ?? 0) ms"
        timestampTextView.text = "Analysis time: " +
            result.analysisUTCTimestamp.convertFormatedStringToFormatedDate()
    }

    func showIconsForMetricResult(result: PageSpeedV5Item) {
        let categoryFCP = PageSpeedCategory(rawValue: result.metrics?.categoryFCP ?? "")
        let categoryFID = PageSpeedCategory(rawValue: result.metrics?.categoryFID ?? "")

        _ = iconFCP.popLastLayer()
        switch categoryFCP {
        case .FAST:
            iconFCP.addCircleLayer(fillColor: UIColor(named: "PageSpeedFastColor")!.cgColor)
            timeFCPLabel.textColor = UIColor(named: "PageSpeedFastSecondaryColor")
        case .AVERAGE:
            iconFCP.addRectangleLayer(fillColor: UIColor(named: "PageSpeedAverageColor")!.cgColor)
            timeFCPLabel.textColor = UIColor(named: "PageSpeedAverageSecondaryColor")
        case .SLOW:
            iconFCP.addTriangleLayer(fillColor: UIColor(named: "PageSpeedSlowColor")!.cgColor)
            timeFCPLabel.textColor = UIColor(named: "PageSpeedSlowSecondaryColor")
        default:
            return
        }
        _ = iconFID.popLastLayer()
        switch categoryFID {
        case .FAST:
            iconFID.addCircleLayer(fillColor: UIColor(named: "PageSpeedFastColor")!.cgColor)
            timeFIDLabel.textColor = UIColor(named: "PageSpeedFastSecondaryColor")
        case .AVERAGE:
            iconFID.addRectangleLayer(fillColor: UIColor(named: "PageSpeedAverageColor")!.cgColor)
            timeFIDLabel.textColor = UIColor(named: "PageSpeedAverageSecondaryColor")
        case .SLOW:
            iconFID.addTriangleLayer(fillColor: UIColor(named: "PageSpeedSlowColor")!.cgColor)
            timeFIDLabel.textColor = UIColor(named: "PageSpeedSlowSecondaryColor")
        default:
            return
        }
    }

    func drawHorizontalMetricCharts(
        result: PageSpeedV5Item,
        duration: Double = 2
    ) {
        let fastProportionFCP = ((result.metrics?.fastProportionFCP ?? 0) * 100).rounded()
        let averageProportionFCP = ((result.metrics?.averageProportionFCP ?? 0) * 100).rounded()
        let slowProportionFCP = ((result.metrics?.slowProportionFCP ?? 0) * 100).rounded()

        let fastProportionFID = ((result.metrics?.fastProportionFID ?? 0) * 100).rounded()
        let averageProportionFID = ((result.metrics?.averageProportionFID ?? 0) * 100).rounded()
        let slowProportionFID = ((result.metrics?.slowProportionFID ?? 0) * 100).rounded()

        fastFCPChartLabel.text = "\(fastProportionFCP)%"
        averageFCPChartLabel.text = "\(averageProportionFCP)%"
        slowFCPChartLabel.text = "\(slowProportionFCP)%"

        fastFIDChartLabel.text = "\(fastProportionFID)%"
        averageFIDChartLabel.text = "\(averageProportionFID)%"
        slowFIDChartLabel.text = "\(slowProportionFID)%"

        let slowFCPChartWidth = max(
            CGFloat(270 * (slowProportionFCP) / 100),
            self.slowFCPChartLabel.intrinsicContentSize.width + 30
        )
        let slowFIDChartWidth = max(
            CGFloat(270 * (slowProportionFID) / 100),
            self.slowFIDChartLabel.intrinsicContentSize.width + 30
        )

        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.fastFCPChartWidthConstraint.constant = 270

            self.averageFCPChartWidthConstraint.constant = CGFloat(
                270 * (averageProportionFCP) / 100
                ) + slowFCPChartWidth + 30
            self.slowFCPChartWidthConstraint.constant = slowFCPChartWidth
            self.fastFCPChart.layoutIfNeeded()
        })

        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.fastFIDChartWidthConstraint.constant = 270

            self.averageFIDChartWidthConstraint.constant = CGFloat(
                270 * (averageProportionFID) / 100
                ) + slowFIDChartWidth + 30
            self.slowFIDChartWidthConstraint.constant = slowFIDChartWidth
            self.fastFIDChart.layoutIfNeeded()
        })
    }
}

// MARK: - UITableViewDataSource
extension PageSpeedHistoryItemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PageSpeedLabData.allCases.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Lab Data"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabDataCell", for: indexPath) as? LabDataTableViewCell
        let id: PageSpeedLabData
        let title: String
        let descriptionMarkdown: SwiftyMarkdown
        let result: String
        let score: Double?

        guard let data = pageSpeedV5Item?.labData else {
            cell?.labDataTitle = "No data"
            return cell!
        }

        switch PageSpeedLabData.allCases[indexPath.row] {
        case .fcp:
            id = .fcp
            title = labDataInfo[.fcp]!.title
            descriptionMarkdown = SwiftyMarkdown(string: labDataInfo[.fcp]!.description)
            result = data.displayValueFCP!
            score = data.scoreFCP.value
        case .fmp:
            id = .fmp
            title = labDataInfo[.fmp]!.title
            descriptionMarkdown = SwiftyMarkdown(string: labDataInfo[.fmp]!.description)
            result = data.displayValueFMP!
            score = data.scoreFMP.value
        case .speedIndex:
            id = .speedIndex
            title = labDataInfo[.speedIndex]!.title
            descriptionMarkdown = SwiftyMarkdown(string: labDataInfo[.speedIndex]!.description)
            result = data.displayValueSpeedIndex!
            score = data.scoreSpeedIndex.value
        case .firstCPUIdle:
            id = .firstCPUIdle
            title = labDataInfo[.firstCPUIdle]!.title
            descriptionMarkdown = SwiftyMarkdown(
                string: labDataInfo[.firstCPUIdle]!.description
            )
            result = data.displayValueFirstCPUIdle!
            score = data.scoreFirstCPUIdle.value
        case .timeToInteractive:
            id = .timeToInteractive
            title = labDataInfo[.timeToInteractive]!.title
            descriptionMarkdown = SwiftyMarkdown(
                string: labDataInfo[.timeToInteractive]!.description
            )
            result = data.displayValueInteractive!
            score = data.scoreInteractive.value
        case .maxPotentialFirstInputDelay:
            id = .maxPotentialFirstInputDelay
            title = labDataInfo[.maxPotentialFirstInputDelay]!.title
            descriptionMarkdown = SwiftyMarkdown(
                string: labDataInfo[.maxPotentialFirstInputDelay]!.description
            )
            result = data.displayValueMaxPotentialFID!
            score = data.scoreMaxPotentialFID.value
        }
        cell?.id = id
        cell?.labDataTitle = title
        cell?.labDataDescription = descriptionMarkdown.attributedString()
        cell?.labDataResult = result
        cell?.labDataScore = score
        cell?.configureCell()
        cell?.selectionStyle = .none
        return cell!
    }
}

// MARK: - UITableViewDelegate
extension PageSpeedHistoryItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
}

// MARK: - UICircularProgressRingDelegate
extension PageSpeedHistoryItemViewController: UICircularProgressRingDelegate {
    func didFinishProgress(for ring: UICircularProgressRing) {
        return
    }

    func didPauseProgress(for ring: UICircularProgressRing) {
        return
    }

    func didContinueProgress(for ring: UICircularProgressRing) {
        return
    }

    func didUpdateProgressValue(for ring: UICircularProgressRing, to newValue: CGFloat) {
        self.overallResultLabel.text = "\(Int(ring.currentValue ?? 0))"
        switch Int(ring.currentValue ?? 0) {
        case 0...49:
            animateColorChange(ring: ring, color: UIColor(named: "PageSpeedSlowColor")!)
        case 50...89:
            animateColorChange(ring: ring, color: UIColor(named: "PageSpeedAverageColor")!)
        case 90...100:
            animateColorChange(ring: ring, color: UIColor(named: "PageSpeedFastColor")!)
        default:
            return
        }
    }

    func animateColorChange(ring: UICircularProgressRing, color: UIColor) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [.curveEaseOut],
            animations: {
                ring.innerRingColor = color
                self.overallResultCircularProgressRingCanvas.backgroundColor = color.withAlphaComponent(0.1)
                self.overallResultLabel.textColor = color
                self.overallResultCircularProgressRingCanvas.layoutIfNeeded()
            })
    }

    func willDisplayLabel(for ring: UICircularProgressRing, _ label: UILabel) {
        return
    }
}
