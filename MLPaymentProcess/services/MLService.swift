//
// Created by MIGUEL MOLDES on 7/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire


class MLService : MLServiceProtocol {

    let config : MLServiceConfig!

    init(config: MLServiceConfig) {
        self.config = config

    }

    func execute(_ request: RequestProtocol,_ retry:Int?) -> Promise<DataResponse<Any>> {
        let operation = Promise<DataResponse<Any>> {
            fulfill, reject in
            let url : URLConvertible = URL(string:self.config.path + request.path)!
            Alamofire.request(url, method: request.method).responseJSON {
                response in

                fulfill(response)

            }
            
        }

        return operation
    }
    
}

protocol MLServiceProtocol {

    func execute(_ request: RequestProtocol,_ retry:Int?) -> Promise<DataResponse<Any>>

}

enum MLServiceError : Error {
    case noJSON

}