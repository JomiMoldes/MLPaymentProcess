//
// Created by MIGUEL MOLDES on 7/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import PromiseKit

class MLPaymentTypeService : MLPaymentTypeServiceProtocol {

    let service : MLServiceProtocol

    init(service:MLServiceProtocol) {
        self.service = service
    }

    func execute() -> Promise<[MLPaymentType]> {
        return Promise<[MLPaymentType]> {
            fulfill, reject in
            let request = MLRequest(requestType: .get, path: MLServiceConfig.paymentType)
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

                var paymentTypes = [MLPaymentType]()

                for type in value {
                    if let name = type["name"] as? String,
                       let thumbnail = type["thumbnail"] as? String,
                       let id = type["id"] as? String {
                        paymentTypes.append(MLPaymentType(id: id, name: name, imagePath: thumbnail))
                    }
                }

                fulfill(paymentTypes)

            }.catch(policy:.allErrors) {
                error in
                reject(error)
            }
        }

    }

}