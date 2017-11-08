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

    func executeData(_ request: RequestProtocol,_ retry:Int?) -> Promise<Data> {
        let operation = Promise<Data> {
            fulfill, reject in
            let url : URLConvertible = URL(string:request.path)!
            Alamofire.request(url, method: request.method).responseData {
                response in

                if let data = response.data {
                    fulfill(data)
                    return
                }

                reject(MLServiceError.noImage)

            }

        }

        return operation
    }
    
}

protocol MLServiceProtocol {

    func execute(_ request: RequestProtocol,_ retry:Int?) -> Promise<DataResponse<Any>>

    func executeData(_ request: RequestProtocol,_ retry:Int?) -> Promise<Data>

}

enum MLServiceError : Error {
    case noJSON
    case noImage

}