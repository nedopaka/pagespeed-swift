//
//  GTMetrixService.swift
//  PageSpeed
//
//  Created by Ilya on 09.02.2020.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import Moya

///Service for getting GTMetrix status of requests and results 
class GTMetrixService: Service {
    internal var identifier: String = ""
    let testID: String!
    init (testID: String) {
        self.testID = testID
        generate()
    }

    func run (completion: @escaping (_ response: GTMetrixResponse?, _ error: Error?) -> Void) {
        started()
        let provider = MoyaProvider<GTMetrixAPI>()
        provider.request(.testStatus(testID: self.testID)) { response in
            switch response {
            case .success(let result):
                let decoder = JSONDecoder()
                do {
                    var testResponse = try decoder.decode(GTMetrixResponse.self, from: result.data)
                    testResponse.id = self.testID
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
