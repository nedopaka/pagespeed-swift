//
//  GTMatrixAPI.swift
//  PageSpeed
//
//  Created by Admin on 09.02.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Moya

enum GTMetrixAPI {
    case testPage(url: String)
    case testStatus(testID: String)
}

extension GTMetrixAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://gtmetrix.com/api/0.1/")!
    }
    var path: String {
        switch self {
        case .testPage:
            return "test"
        case .testStatus(let testID):
            return "test/\(testID)"
        }
    }
    var method: Method {
        switch self {
        case .testPage:
            return .post
        case .testStatus:
            return .get
        }
    }
    var sampleData: Data {
        Data()
    }
    var task: Task {
        switch self {
        case let .testPage(url):
            return .requestParameters(parameters: ["url": url], encoding: URLEncoding.default)
        case .testStatus(let testID):
            return .requestParameters(parameters: ["test_id": testID], encoding: URLEncoding.default)
        }
    }
    var headers: [String: String]? {
        let user = "viper3150@gmail.com"
        let password = "819dbe19a4fb3c4e53ad2cb0fedf7e1f"
        let auth64 = "\(user):\(password)".data(using: .utf8)?.base64EncodedString() ?? ""
        return [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Basic \(auth64)"
        ]
    }
}
