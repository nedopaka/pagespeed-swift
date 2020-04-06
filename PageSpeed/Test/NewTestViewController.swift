//
//  TestViewController.swift
//  PageSpeed
//
//  Created by Alex on 2/5/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit
import Moya

var servicesArr = [
    (id: "pagespeed", name: "Google PageSpeed Insights"),
    (id: "gtmetrix", name: "GTMetrix")
]

class NewTestViewController: UIViewController {

    // MARK: - Properties
    let googleAPIKey = "AIzaSyBD3l3hyQYCJT3_yHCXcD8opyZ1uJer1EA"
    var provider = MoyaProvider<PageSpeedAPI>()
    var servicesEnabledArr: [String] = []
    let dispatchGroup = DispatchGroup()
    var isErrorAccured = false
    var mobilePageSpeedResult: PageSpeedResponse?
    var desktopPageSpeedResult: PageSpeedResponse?
    var gtMetrixResponse: GTMetrixResponseItem?
    enum PageSpeedStrategy: String {
        case mobile
        case desktop
    }

    private var servicesTableViewHeight: CGFloat {
        servicesTableView.layoutIfNeeded()
        return servicesTableView.contentSize.height
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var urlTextField: UITextField!
    @IBOutlet private weak var servicesTableView: UITableView!
    @IBOutlet private weak var servicesTableViewHeightConstraint: NSLayoutConstraint!

    // MARK: - IBActions
    @IBAction private func performTest(_ sender: Any) {
        var url = urlTextField.text!

        if url.isEmpty {
            self.presentAlert(
                title: "Attention",
                message: "The URL field is empty. Fill the corresponding field.",
                options: "OK"
            ) { _ in
                self.urlTextField.becomeFirstResponder()
                self.urlTextField.shake(duration: 0.6)
            }
            return
        }
        if url.isValidURL {
            isErrorAccured = false
            processRequestsToServices(url: url)
        } else {
            url = "https://" + url
            if url.isValidURL {
                urlTextField.text = url
                isErrorAccured = false
                processRequestsToServices(url: url)
            } else {
                self.presentAlert(
                    title: "Attention",
                    message: "The URL is not valid.",
                    options: "OK"
                ) { _ in
                    self.urlTextField.becomeFirstResponder()
                }
            }
        }
    }

    // MARK: - Methods
    func processRequestsToServices(url: String) {
        if servicesEnabledArr.isEmpty {
            self.presentAlert(
                title: "Attention",
                message: "There are no services selected. Please, choose one to perform test.",
                options: "OK"
            ) { _ in
                self.urlTextField.becomeFirstResponder()
                self.servicesTableView.shake(duration: 0.6)
            }
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            if self.servicesEnabledArr.contains("gtmetrix") {
                self.addGTMetrixTestTask(url: url)
            }
            if self.servicesEnabledArr.contains("pagespeed") {
                self.addPageSpeedTestTask(url: url, strategy: .mobile)
                self.addPageSpeedTestTask(url: url, strategy: .desktop)
            }
            self.dispatchGroup.notify(queue: .main) {
                if self.isErrorAccured { return }
                let testResultsViewController = UIStoryboard(
                    name: "Stage-A",
                    bundle: nil
                ).instantiateViewController(identifier: "TestResultsViewController")
                    as? TestResultsViewController
                testResultsViewController?.url = self.urlTextField.text
                testResultsViewController?.mobilePageSpeedResult = self.mobilePageSpeedResult
                testResultsViewController?.desktopPageSpeedResult = self.desktopPageSpeedResult
                testResultsViewController?.servicesEnabledArr = self.servicesEnabledArr
                testResultsViewController?.gtMetrixResponse = self.gtMetrixResponse
                self.navigationController?.pushViewController(testResultsViewController!, animated: true)
            }
        }
    }

    func addGTMetrixTestTask(url: String) {
        dispatchGroup.enter()
        GTMetrixURLService(url: url).start { response, error in
            if let error = error {
                print(error)
            } else if let response = response {
                self.gtMetrixResponse = GTMetrixResponseItem(response: response)
                if let gtMetrixResponse = self.gtMetrixResponse, let manager = DBManager.sharedInstance {
                    manager.save(object: gtMetrixResponse)
                }
            }
            self.dispatchGroup.leave()
        }
    }

    func addPageSpeedTestTask(url: String, strategy: PageSpeedStrategy) {
        dispatchGroup.enter()
        requestToPageSpeed(
            url: url,
            strategy: strategy
        ) { response, error in
            if let error = error {
                self.presentErrorAlert(
                    title: (error.response?.statusCode.description)!,
                    message: error.response!.description
                )
            }
            self.dispatchGroup.leave()
        }
    }

    func presentErrorAlert(title: String, message: String) {
        self.presentAlert(
            title: title,
            message: message,
            options: "OK"
        ) { _ in
            self.urlTextField.becomeFirstResponder()
            self.urlTextField.selectAll(nil)
        }
    }

    func requestToPageSpeed(
        url: String,
        strategy: PageSpeedStrategy,
        completionHandler: @escaping (_ response: Response?, _ error: MoyaError?) -> Void = { _, _ in }
    ) {
        provider.request(.runPagespeed(key: googleAPIKey, url: url, strategy: strategy.rawValue)) { result in
            do {
                let error = try result
                    .get()
                let pageSpeedError = try error.map(PageSpeedError.self)
                self.isErrorAccured = true
                self.presentErrorAlert(
                    title: "PageSpeed Error: \(pageSpeedError.error.code)",
                    message: pageSpeedError.error.message
                )
                print(pageSpeedError)
                completionHandler(nil, nil)
                return
            } catch {
                print(error)
            }
            do {
                let response = try result
                    .get()
                    .filter(statusCode: 200)
                let pageSpeedResult = try response.map(PageSpeedResponse.self)
                debugPrint(pageSpeedResult)
                switch strategy {
                case .mobile:
                    self.mobilePageSpeedResult = pageSpeedResult
                case .desktop:
                    self.desktopPageSpeedResult = pageSpeedResult
                }
                // store result to Realm
                let testResult = PageSpeedV5Item(response: pageSpeedResult)
                _ = DBManager.sharedInstance?.addPageSpeedV5Item(object: testResult)

                completionHandler(response, nil)
            } catch {
                self.isErrorAccured = true
                print(error)
                completionHandler(nil, error as? MoyaError)
            }
        }
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Test"
        servicesTableView.separatorStyle = .singleLine
        for item in servicesArr {
            servicesEnabledArr.append(item.id)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = servicesTableViewHeight
        servicesTableViewHeightConstraint.constant = height
        servicesTableView.layoutIfNeeded()
        servicesTableView.isScrollEnabled = false
        urlTextField.addBottomBorder(color: .gray, width: 1)
    }
}

// MARK: - UITableViewDataSource
extension NewTestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        servicesArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let service = servicesArr[indexPath.row]
        let cell = servicesTableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath)
            as? ServiceTableViewCell

        cell?.id = service.id
        cell?.displayName = service.name
        cell?.serviceSwitchChangeCallback = {
            self.testConfig(id: service.id, enabled: cell?.serviceEnabled ?? false)
        }

        cell?.separatorInset = .zero
        cell?.layoutMargins = .zero
        cell?.selectionStyle = .none
        return cell!
    }

    func testConfig(id: String, enabled: Bool) {
        if enabled {
            servicesEnabledArr.addItemIfNotExist(id)
        } else {
            servicesEnabledArr.removeItemIfExist(id)
        }
        print("switch \(id) \(enabled)")
    }
}
