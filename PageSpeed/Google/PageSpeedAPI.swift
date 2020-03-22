//
//  PageSpeedAPI.swift
//  PageSpeed
//
//  Created by Alex on 2/3/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Moya

enum PageSpeedAPI {
    case runPagespeed(key: String, url: String, strategy: String)
}

extension PageSpeedAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://www.googleapis.com/pagespeedonline/v5/")!
    }

    var path: String {
        switch self {
        case .runPagespeed:
            return "runPagespeed"
        }
    }
    
    var method: Method {
        .get
    }

    var sampleData: Data {
        Data()
    }

    var task: Task {
        switch self {
        case let .runPagespeed(key, url, strategy):
            return .requestParameters(
                parameters: ["key": key, "url": url, "strategy": strategy], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        ["Content-Type": "application/json", "Accept-Encoding": "gzip, deflate, br"]
    }
}
