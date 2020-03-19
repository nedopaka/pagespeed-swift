//
//  GTMetrixURLService.swift
//  PageSpeed
//
//  Created by Ilya on 10.02.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Moya

class GTMetrixURLService: Service {
    internal var identifier: String = ""
    private var testID: String = ""
    private var timer: Timer?
    let url: String!
    init (url: String) {
        self.url = url
        generate()
    }

    func start (completion: @escaping (_ response: GTMetrixResponse?, _ error: Error?) -> Void) {
        started()
        GTMetrixResultService(url: url).run { response, error in
            if let response = response {
                self.testID = response.testID
                self.checkStatus(completion: completion)
            } else {
                completion(nil, error)
                self.finished()
            }
        }
    }

    func checkStatus (completion: @escaping (_ response: GTMetrixResponse?, _ error: Error?) -> Void) {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { timer in
            GTMetrixService(testID: self.testID).run { response, error in
                if let response = response {
                    if let state = TestState(rawValue: response.state) {
                        switch state {
                        case .queued:
                            print("queued")
                        case .started:
                            print("started")
                        case .completed:
                            self.timer?.invalidate()
                            self.timer = nil
                            var result = response
                            result.url = self.url
                            result.date = Date()
                            completion(result, nil)
                            self.finished()
                            print("completed")
                        case .error:
                            self.timer?.invalidate()
                            self.timer = nil
                            completion(nil, CustomError.custom(error: response.error))
                            self.finished()
                            print("error")
                        }
                    }
                } else {
                    print("else")
                    self.timer?.invalidate()
                    self.timer = nil
                    completion(nil, error)
                    self.finished()
                }
            }
        })
    }
}
