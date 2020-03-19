//
//  GTMetrixResourceService.swift
//  PageSpeed
//
//  Created by Ilya on 10.03.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Moya

enum TestResourse: String {
    case screenshot, har, pagespeed, pagespeedFiles = "pagespeed-files", yslow, reportPdf = "report-pdf", video
}
class GTMetrixResourceService: Service {
    internal var identifier: String = ""
    let testID: String!
    let resource: TestResourse!
    init (testID: String, resource: TestResourse) {
        self.testID = testID
        self.resource = resource
        generate()
    }

    func run (completion: @escaping (_ image: UIImage?, _ data: Data?, _ error: Error?) -> Void) {
        started()
        let provider = MoyaProvider<GTMetrixAPI>()
        provider.request(.testResource(testID: self.testID, resource: resource.rawValue)) { [weak self] response in
            switch response {
            case .success(let result):
                guard let resource = self?.resource else {
                    return
                }
                switch resource {
                case .screenshot:
                    let image = UIImage(data: result.data)
                    completion(image, result.data, nil)
                case .har:
                    completion(nil, result.data, nil)
                case .pagespeed:
                    completion(nil, result.data, nil)
                case .pagespeedFiles:
                    completion(nil, result.data, nil)
                case .yslow:
                    completion(nil, result.data, nil)
                case .reportPdf:
                    completion(nil, result.data, nil)
                case .video:
                    completion(nil, result.data, nil)
                }
            case .failure(let error):
                completion(nil, nil, error)
            }
            self?.finished()
        }
    }
}
