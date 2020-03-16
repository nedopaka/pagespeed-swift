//
//  PageSpeedResultViewController.swift
//  PageSpeed
//
//  Created by Alex on 2/23/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit
import UICircularProgressRing
import Kingfisher
import SwiftyMarkdown

enum PageSpeedResult {
    case mobile
    case desktop
}

enum PageSpeedColor: String {
    case green = "#0cce6b"
    case greenSecondary = "#018642"
    case orange = "#ffa400"
    case orangeSecondary = "#d04900"
    case red = "#ff4e42"
    case redSecondary = "#eb0f00"
}

enum PageSpeedCategory: String {
    case FAST
    case AVERAGE
    case SLOW
}

enum PageSpeedLabData: CaseIterable {
    case fcp
    case fmp
    case speedIndex
    case firstCPUIdle
    case timeToInteractive
    case maxPotentialFirstInputDelay
}

// swiftlint:disable large_tuple
class PageSpeedResultViewController: UIViewController {

    // MARK: - Properties

    var url: String?
    var viewShowed: Bool?
    var mobilePageSpeedResult, desktopPageSpeedResult: PageSpeedResponse?
    private var overallMobileScore, overallDesktopScore: Double?

    typealias MetricResult = (time: Int, fast: Int, average: Int, slow: Int, category: String)
    var mobileFCP, desktopFCP: MetricResult?
    var mobileFID, desktopFID: MetricResult?
    var mobileLoadingOverallCategory, desktopLoadingOverallCategory: PageSpeedCategory?

    var labDataTableViewHeight: CGFloat {
        labDataTableView.layoutIfNeeded()
        return labDataTableView.contentSize.height
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var urlLabel: UILabel!
    @IBOutlet private weak var showResultSegmentedControl: UISegmentedControl!

    // Result CircularProgressRing
    @IBOutlet private weak var overallResultCircularProgressRing: UICircularProgressRing!
    @IBOutlet private weak var overallResultLabel: UILabel!
    @IBOutlet private weak var overallResultCircularProgressRingCanvas: UIView!

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
            overallResultCircularProgressRing.startProgress(to: CGFloat(overallMobileScore ?? 0), duration: 0.5) {
                print("Overall mobile score displayed")
            }
            showResultDetails(result: .mobile)
            drawHorizontalMetricCharts(resultFCP: mobileFCP, resultFID: mobileFID, duration: 0.5)
            showFinalScreenshot(result: .mobile)
            showFieldDataOverallCategory(result: .mobile)
        } else {
            overallResultCircularProgressRing.startProgress(to: CGFloat(overallDesktopScore ?? 0), duration: 0.5) {
                print("Overall desktop score displayed")
            }
            showResultDetails(result: .desktop)
            drawHorizontalMetricCharts(resultFCP: desktopFCP, resultFID: desktopFID, duration: 0.5)
            showFinalScreenshot(result: .desktop)
            showFieldDataOverallCategory(result: .desktop)
        }
        labDataTableView.reloadData()
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        urlLabel.text = url
        getResultDetails()
        prepareLayout()
        showFieldDataOverallCategory(result: .mobile)
        showResultDetails(result: .mobile)
        showFinalScreenshot(result: .mobile)
    }

    override func viewDidLayoutSubviews() {
        let labDataTableHeight = labDataTableViewHeight
        labDataTableViewHeightConstraint.constant = labDataTableHeight
        labDataTableView.layoutIfNeeded()
        labDataTableView.isScrollEnabled = false
    }

    override func viewDidAppear(_ animated: Bool) {
        if viewShowed != nil { return }
        super.viewDidAppear(animated)
        overallResultCircularProgressRing.startProgress(to: CGFloat(overallMobileScore ?? 0), duration: 0.5) {
            print("Overall mobile score displayed")
        }
        drawHorizontalMetricCharts(resultFCP: mobileFCP, resultFID: mobileFID)
        viewShowed = true
    }

    // MARK: - Methods

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

    func showFieldDataOverallCategory(result: PageSpeedResult) {
        let category: PageSpeedCategory?
        switch result {
        case .mobile:
            category = mobileLoadingOverallCategory
        case .desktop:
            category = desktopLoadingOverallCategory
        }
        let color: UIColor?
        switch category {
        case .FAST:
            color = UIColor(named: "PageSpeedFastSecondaryColor")
        case .AVERAGE:
            color = UIColor(named: "PageSpeedAverageSecondaryColor")
        case .SLOW:
            color = UIColor(named: "PageSpeedSlowSecondaryColor")
        default:
            return
        }
        fieldDataOverallCategory.text = "\(category?.rawValue ?? "") speed".capitalized
        fieldDataOverallCategory.textColor = color
    }

    func showFinalScreenshot(result: PageSpeedResult) {
        let source: PageSpeedResponse?
        switch result {
        case .mobile:
            source = mobilePageSpeedResult
        case .desktop:
            source = desktopPageSpeedResult
        }
        let finalScreenshot = source?.lighthouseResult.audits.finalScreenshot.details.data.base64Convert()
        finalScreenshotImageView.image = finalScreenshot
    }

    func getResultDetails() {
        overallMobileScore = (mobilePageSpeedResult?.lighthouseResult.categories.performance.score ?? 0) * 100
        overallDesktopScore = (desktopPageSpeedResult?.lighthouseResult.categories.performance.score ?? 0) * 100
        if let mobilePageSpeedResult = mobilePageSpeedResult {
            mobileFCP = getFCP(pageSpeedResult: mobilePageSpeedResult)
            mobileFID = getFID(pageSpeedResult: mobilePageSpeedResult)
            mobileLoadingOverallCategory = getLoadingOverallCategory(pageSpeedResult: mobilePageSpeedResult)
        }
        if let desktopPageSpeedResult = desktopPageSpeedResult {
            desktopFCP = getFCP(pageSpeedResult: desktopPageSpeedResult)
            desktopFID = getFID(pageSpeedResult: desktopPageSpeedResult)
            desktopLoadingOverallCategory = getLoadingOverallCategory(pageSpeedResult: desktopPageSpeedResult)
        }
    }

    func showResultDetails(result: PageSpeedResult) {
        let timestampStr = "Analysis time: "
        switch result {
        case .mobile:
            showIconsForMetricResult(resultFCP: mobileFCP, resultFID: mobileFID)
            let mobileFCPTimeInSec = Double(mobileFCP?.time ?? 0) / 1_000
            timeFCPLabel.text = "\(String(format: "%.2f", mobileFCPTimeInSec)) s"
            timeFIDLabel.text = "\(mobileFID?.time ?? 0) ms"
            timestampTextView.text = timestampStr +
                (mobilePageSpeedResult?.analysisUTCTimestamp.convertFormatedStringToFormatedDate() ?? "")
        case .desktop:
            showIconsForMetricResult(resultFCP: desktopFCP, resultFID: desktopFID)
            let desktopFCPTimeInSec = Double(desktopFCP?.time ?? 0) / 1_000
            timeFCPLabel.text = "\(String(format: "%.2f", desktopFCPTimeInSec)) s"
            timeFIDLabel.text = "\(desktopFID?.time ?? 0) ms"
            timestampTextView.text = timestampStr +
                (desktopPageSpeedResult?.analysisUTCTimestamp.convertFormatedStringToFormatedDate() ?? "")
        }
    }

    func showIconsForMetricResult(
        resultFCP: MetricResult?,
        resultFID: MetricResult?
    ) {
        _ = iconFCP.popLastLayer()
        switch resultFCP?.category {
        case "FAST":
            iconFCP.addCircleLayer(fillColor: UIColor(named: "PageSpeedFastColor")!.cgColor)
            timeFCPLabel.textColor = UIColor(named: "PageSpeedFastSecondaryColor")
        case "AVERAGE":
            iconFCP.addRectangleLayer(fillColor: UIColor(named: "PageSpeedAverageColor")!.cgColor)
            timeFCPLabel.textColor = UIColor(named: "PageSpeedAverageSecondaryColor")
        case "SLOW":
            iconFCP.addTriangleLayer(fillColor: UIColor(named: "PageSpeedSlowColor")!.cgColor)
            timeFCPLabel.textColor = UIColor(named: "PageSpeedSlowSecondaryColor")
        default:
            return
        }
        _ = iconFID.popLastLayer()
        switch resultFID?.category {
        case "FAST":
            iconFID.addCircleLayer(fillColor: UIColor(named: "PageSpeedFastColor")!.cgColor)
            timeFIDLabel.textColor = UIColor(named: "PageSpeedFastSecondaryColor")
        case "AVERAGE":
            iconFID.addRectangleLayer(fillColor: UIColor(named: "PageSpeedAverageColor")!.cgColor)
            timeFIDLabel.textColor = UIColor(named: "PageSpeedAverageSecondaryColor")
        case "SLOW":
            iconFID.addTriangleLayer(fillColor: UIColor(named: "PageSpeedSlowColor")!.cgColor)
            timeFIDLabel.textColor = UIColor(named: "PageSpeedSlowSecondaryColor")
        default:
            return
        }
    }

    func getLabDataAudits(pageSpeedResult: PageSpeedResponse?) -> Audits? {
        let audits = pageSpeedResult?
        .lighthouseResult
        .audits

        return audits
    }

    func getLoadingOverallCategory(pageSpeedResult: PageSpeedResponse) -> PageSpeedCategory? {
        let overallCategory = pageSpeedResult
            .loadingExperience
            .overallCategory
        return PageSpeedCategory(rawValue: overallCategory)
    }

    func getFCP(pageSpeedResult: PageSpeedResponse) -> MetricResult {
        // time in ms
        let timeFCP = pageSpeedResult
            .loadingExperience
            .metrics
            .firstContentfulPaintMS
            .percentile

        let fastFCP = Int(
            ((pageSpeedResult
                .loadingExperience
                .metrics
                .firstContentfulPaintMS
                .distributions[0]
                .proportion) * 100).rounded()
            )
        let averageFCP = Int(
            ((pageSpeedResult
                .loadingExperience
                .metrics
                .firstContentfulPaintMS
                .distributions[1]
                .proportion) * 100).rounded()
            )
        let slowFCP = Int(
            ((pageSpeedResult
                .loadingExperience
                .metrics
                .firstContentfulPaintMS
                .distributions[2]
                .proportion) * 100).rounded()
            )
        let categoryFCP = pageSpeedResult
            .loadingExperience
            .metrics
            .firstContentfulPaintMS
            .category

        return (timeFCP, fastFCP, averageFCP, slowFCP, categoryFCP)
    }

    func getFID(pageSpeedResult: PageSpeedResponse) -> MetricResult {
        // time in ms
        let timeFID = pageSpeedResult
            .loadingExperience
            .metrics
            .firstInputDelayMS
            .percentile

        let fastFID = Int(
            ((pageSpeedResult
                .loadingExperience
                .metrics
                .firstInputDelayMS
                .distributions[0]
                .proportion) * 100).rounded()
            )
        let averageFID = Int(
            ((pageSpeedResult
                .loadingExperience
                .metrics
                .firstInputDelayMS
                .distributions[1]
                .proportion) * 100).rounded()
            )
        let slowFID = Int(
            ((pageSpeedResult
                .loadingExperience
                .metrics
                .firstInputDelayMS
                .distributions[2]
                .proportion) * 100).rounded()
            )
        let categoryFID = pageSpeedResult
            .loadingExperience
            .metrics
            .firstInputDelayMS
            .category

        return (time: timeFID, fast: fastFID, average: averageFID, slow: slowFID, categoryFID)
    }

    func drawHorizontalMetricCharts(
        resultFCP: MetricResult?,
        resultFID: MetricResult?,
        duration: Double = 2
    ) {
        fastFCPChartLabel.text = "\(resultFCP?.fast ?? 0)%"
        averageFCPChartLabel.text = "\(resultFCP?.average ?? 0)%"
        slowFCPChartLabel.text = "\(resultFCP?.slow ?? 0)%"

        fastFIDChartLabel.text = "\(resultFID?.fast ?? 0)%"
        averageFIDChartLabel.text = "\(resultFID?.average ?? 0)%"
        slowFIDChartLabel.text = "\(resultFID?.slow ?? 0)%"

        let slowFCPChartWidth = max(
            CGFloat(270 * (resultFCP?.slow ?? 0) / 100),
            self.slowFCPChartLabel.intrinsicContentSize.width + 30
        )
        let slowFIDChartWidth = max(
            CGFloat(270 * (resultFID?.slow ?? 0) / 100),
            self.slowFIDChartLabel.intrinsicContentSize.width + 30
        )

        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.fastFCPChartWidthConstraint.constant = 270

            self.averageFCPChartWidthConstraint.constant = CGFloat(
                270 * (resultFCP?.average ?? 0) / 100
                ) + slowFCPChartWidth + 30
            self.slowFCPChartWidthConstraint.constant = slowFCPChartWidth
            self.fastFCPChart.layoutIfNeeded()
        })

        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.fastFIDChartWidthConstraint.constant = 270

            self.averageFIDChartWidthConstraint.constant = CGFloat(
                270 * (resultFID?.average ?? 0) / 100
                ) + slowFIDChartWidth + 30
            self.slowFIDChartWidthConstraint.constant = slowFIDChartWidth
            self.fastFIDChart.layoutIfNeeded()
        })
    }
}

extension PageSpeedResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PageSpeedLabData.allCases.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Lab Data"
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabDataCell", for: indexPath) as? LabDataTableViewCell
        let audits = showResultSegmentedControl.selectedSegmentIndex == 0
            ? getLabDataAudits(pageSpeedResult: mobilePageSpeedResult)
            : getLabDataAudits(pageSpeedResult: desktopPageSpeedResult)
        let id: PageSpeedLabData
        let title: String
        let descriptionMarkdown: SwiftyMarkdown
        let result: String
        let score: Double?
        switch PageSpeedLabData.allCases[indexPath.row] {
        case .fcp:
            id = .fcp
            title = audits?.firstContentfulPaint.title ?? "FCP"
            descriptionMarkdown = SwiftyMarkdown(string: audits?.firstContentfulPaint.description ?? "FCP description")
            result = audits?.firstContentfulPaint.displayValue ?? ""
            score = audits?.firstContentfulPaint.score
        case .fmp:
            id = .fmp
            title = audits?.firstMeaningfulPaint.title ?? "FMP"
            descriptionMarkdown = SwiftyMarkdown(string: audits?.firstMeaningfulPaint.description ?? "FMP description")
            result = audits?.firstMeaningfulPaint.displayValue ?? ""
            score = audits?.firstMeaningfulPaint.score
        case .speedIndex:
            id = .speedIndex
            title = audits?.speedIndex.title ?? "Speed Index"
            descriptionMarkdown = SwiftyMarkdown(string: audits?.speedIndex.description ?? "SpeedIndex description")
            result = audits?.speedIndex.displayValue ?? ""
            score = audits?.speedIndex.score
        case .firstCPUIdle:
            id = .firstCPUIdle
            title = audits?.firstCPUIdle.title ?? "First CPU Idle"
            descriptionMarkdown = SwiftyMarkdown(
                string: audits?.firstCPUIdle.description ?? "First CPU Idle description"
            )
            result = audits?.firstCPUIdle.displayValue ?? ""
            score = audits?.firstCPUIdle.score
        case .timeToInteractive:
            id = .timeToInteractive
            title = audits?.interactive.title ?? "Time to Interactive"
            descriptionMarkdown = SwiftyMarkdown(
                string: audits?.interactive.description ?? "Time to Interactive description"
            )
            result = audits?.interactive.displayValue ?? ""
            score = audits?.interactive.score
        case .maxPotentialFirstInputDelay:
            id = .maxPotentialFirstInputDelay
            title = audits?.maxPotentialFid.title ?? "Max Potential FID"
            descriptionMarkdown = SwiftyMarkdown(
                string: audits?.maxPotentialFid.description ?? "Max Potential FID description"
            )
            result = audits?.maxPotentialFid.displayValue ?? ""
            score = audits?.maxPotentialFid.score
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

extension PageSpeedResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
}

extension PageSpeedResultViewController: UICircularProgressRingDelegate {
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
