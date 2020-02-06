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

    // MARK: - Variables
    let googleAPIKey = "AIzaSyBD3l3hyQYCJT3_yHCXcD8opyZ1uJer1EA"
    var provider = MoyaProvider<PageSpeedAPI>()

    // MARK: - IBOutlets
    @IBOutlet private weak var urlTextField: UITextField!
    @IBOutlet private weak var responseTextView: UITextView!

    // MARK: - IBAction
    @IBAction private func performRequest(_ sender: Any) {
        let url = urlTextField.text!
        if url.isValidURL {
            requestToPageSpeed(url: url)
        }
    }

    func requestToPageSpeed(
        url: String,
        completionHandler: @escaping (_ response: Response?, _ error: MoyaError?) -> Void = { _, _ in }
    ) {
        provider.request(.runPagespeed(key: googleAPIKey, url: url)) { result in
            do {
                let response = try result
                    .get()
                    .filter(statusCode: 200)
                let pageSpeedResult = try response.map(PageSpeedResponse.self)
                debugPrint(pageSpeedResult)
                completionHandler(response, nil)
            } catch {
                print(error)
                completionHandler(nil, error as? MoyaError)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Test"
        UIView.animate(withDuration: 2, animations: {
            self.view.backgroundColor = .yellow
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
