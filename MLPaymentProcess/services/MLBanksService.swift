//
// Created by MIGUEL MOLDES on 8/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import PromiseKit

protocol MLBankServiceProtocol {

    func execute() -> Promise<[MLBank]>

}

class MLBankService : MLBankServiceProtocol {

    let service : MLServiceProtocol
    let userInfo : MLUserPaymentInfo

    init(service:MLServiceProtocol, userInfo: MLUserPaymentInfo) {
        self.service = service
        self.userInfo = userInfo
    }

    func execute() -> Promise<[MLBank]> {

        return Promise<[MLBank]> {
            fulfill, reject in

            let request = MLRequest(requestType: .get, path: MLServiceConfig.banksPath + self.userInfo.creditCard)
            self.service.execute(request, nil).then {
                response -> Void in

                guard response.error == nil else {
                    reject(response.error!)
                    return
                }

                guard let value = response.result.value as? [[String: Any]] else {
                    reject(MLServiceError.noJSON)
                    return
                }

                var banks = [MLBank]()

                for type in value {
                    if let name = type["name"] as? String,
                       let thumbnail = type["thumbnail"] as? String,
                       let id = type["id"] as? String {
                        banks.append(MLBank(id: id, name: name, imagePath: thumbnail))
                    }
                }

                fulfill(banks)

            }.catch(policy:.allErrors) {
                error in
                reject(error)
            }
            
        }

    }

}