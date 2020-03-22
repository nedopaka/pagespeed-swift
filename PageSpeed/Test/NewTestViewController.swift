//
//  TestViewController.swift
//  PageSpeed
//
//  Created by Alex on 2/5/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit
import Moya

class NewTestViewController: UIViewController {

    // MARK: - Properties
    let googleAPIKey = "AIzaSyBD3l3hyQYCJT3_yHCXcD8opyZ1uJer1EA"
    var provider = MoyaProvider<PageSpeedAPI>()
    var servicesArr = [
        (id: "pagespeed", name: "Google PageSpeed Insights"),
        (id: "gtmetrix", name: "GTMetrix")
    ]
    var mobilePageSpeedResult: PageSpeedResponse?
    var desktopPageSpeedResult: PageSpeedResponse?
    var gtMetrixResponse: GTMetrixResponseItem?
    enum PageSpeedStrategy: String {
        case mobile
        case desktop
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var urlTextField: UITextField!
    @IBOutlet private weak var responseTextView: UITextView!
    @IBOutlet private weak var strategySegmentedControl: UISegmentedControl!
    @IBOutlet private weak var servicesTableView: UITableView!

    // MARK: - IBActions
    @IBAction private func performTest(_ sender: Any) {
        var url = urlTextField.text!

        if url.isValidURL {
            processRequestsToServices(url: url)
        } else {
            url = "https://" + url
            if url.isValidURL {
                urlTextField.text = url
                processRequestsToServices(url: url)
            } else {
                showAlert(title: "Info", message: "Please enter valid URL")
            }
        }
    }

    // MARK: - Methods
    func processRequestsToServices(url: String) {
        gtMetrixResponse = nil
        let dispatchGroup = DispatchGroup()
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
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        requestToPageSpeed(
            url: url,
            strategy: .mobile
        ) { response, error in
            if let error = error {
                self.showAlert(title: (error.response?.statusCode.description)!, message: error.response!.description) {
                    self.urlTextField.becomeFirstResponder()
                    self.urlTextField.selectAll(nil)
                }
            }
            DispatchQueue.main.async {
                dispatchGroup.leave()
            }
        }
        dispatchGroup.enter()
        requestToPageSpeed(
            url: url,
            strategy: .desktop
        ) { response, error in
            if let error = error {
                self.showAlert(title: (error.response?.statusCode.description)!, message: error.response!.description) {
                    self.urlTextField.becomeFirstResponder()
                    self.urlTextField.selectAll(nil)
                }
            }
            DispatchQueue.main.async {
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            let testResultsViewController = UIStoryboard(
                name: "Stage-A",
                bundle: nil
            ).instantiateViewController(identifier: "TestResultsViewController")
                as? TestResultsViewController
            testResultsViewController?.url = self.urlTextField.text
            testResultsViewController?.mobilePageSpeedResult = self.mobilePageSpeedResult
            testResultsViewController?.desktopPageSpeedResult = self.desktopPageSpeedResult
            testResultsViewController?.servicesArr = self.servicesArr
            testResultsViewController?.gtMetrixResponse = self.gtMetrixResponse
            self.navigationController?.pushViewController(testResultsViewController!, animated: true)
        }
    }

    func requestToPageSpeed(
        url: String,
        strategy: PageSpeedStrategy,
        completionHandler: @escaping (_ response: Response?, _ error: MoyaError?) -> Void = { _, _ in }
    ) {
        provider.request(.runPagespeed(key: googleAPIKey, url: url, strategy: strategy.rawValue)) { result in
            do {
                let response = try result
                    .get()
                    .filter(statusCode: 200)
                let pageSpeedResult = try response.map(PageSpeedResponse.self)
                debugPrint(pageSpeedResult)
                self.responseTextView.text = ""
                debugPrint(pageSpeedResult, to: &self.responseTextView.text)
                switch strategy {
                case .mobile:
                    self.mobilePageSpeedResult = pageSpeedResult
                case .desktop:
                    self.desktopPageSpeedResult = pageSpeedResult
                }
                completionHandler(response, nil)
            } catch {
                print(error)
                completionHandler(nil, error as? MoyaError)
            }
        }
    }

    func showAlert(title: String, message: String, dismissCompletion: (() -> Void)? = nil) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(
            title: "OK",
            style: .cancel,
            handler: { ( _ : UIAlertAction) -> Void in
                alertController.dismiss(animated: true, completion: dismissCompletion)
            }
        )
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Test"
        UIView.animate(withDuration: 2, animations: {
            self.view.backgroundColor = .yellow
        })
        servicesTableView.separatorStyle = .none
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

        cell?.separatorInset = .zero
        cell?.layoutMargins = .zero
        cell?.selectionStyle = .none
        return cell!
    }
}
