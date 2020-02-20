//
//  GTMTestService.swift
//  PageSpeed
//
//  Created by Admin on 09.02.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Moya

class GTMTestService: Service {
    internal var identifier: String = ""
    let url: String!
    init (url: String) {
        self.url = url
        generate()
    }
    func run (completion: @escaping (_ response: GTMTestResponse?, _ error: Error?) -> Void) {
        started()
        let provider = MoyaProvider<GTMatrixAPI>()
        provider.request(.testPage(url: self.url)) { response in
            switch response {
            case .success(let result):
                print(String(data: result.data, encoding: .utf8))
                let decoder = JSONDecoder()
                do {
                    let testResponse = try decoder.decode(GTMTestResponse.self, from: result.data)
                    completion(testResponse, nil)
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
            self.finished()
        }
    }
}
