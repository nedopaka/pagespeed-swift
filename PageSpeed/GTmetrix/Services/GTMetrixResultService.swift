//
//  GTMetrixResultService.swift
//  PageSpeed
//
//  Created by Ilya on 09.02.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Moya

///Service for initialization GTMetrix requests 
class GTMetrixResultService: Service {
    internal var identifier: String = ""
    let url: String!
    init (url: String) {
        self.url = url
        generate()
    }

    func run (completion: @escaping (_ response: GTMetrixTestResponse?, _ error: Error?) -> Void) {
        started()
        let provider = MoyaProvider<GTMetrixAPI>()
        provider.request(.testPage(url: self.url)) { response in
            switch response {
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    let testResponse = try decoder.decode(GTMetrixTestResponse.self, from: result.data)
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
