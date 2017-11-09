//
// Created by MIGUEL MOLDES on 9/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import PromiseKit

protocol MLInstallmentsServiceProtocol {

    func execute() -> Promise<[MLInstallment]>

}

class MLInstallmentsService : MLInstallmentsServiceProtocol {

    let service : MLServiceProtocol
    let userInfo : MLUserPaymentInfo

    init(service:MLServiceProtocol, userInfo: MLUserPaymentInfo) {
        self.service = service
        self.userInfo = userInfo
    }

    func execute() -> Promise<[MLInstallment]> {
        return Promise<[MLInstallment]> {
            fulfill, reject in

            let path = MLServiceConfig.getInstallmentsPath(amount: "\(self.userInfo.amountToPay)", paymentType: self.userInfo.creditCard, issuer: Int(self.userInfo.bank)!)
            let request = MLRequest(requestType: .get, path: path)
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

                guard let costs = value.first?["payer_costs"] as? [[String: Any]] else {
                    reject(MLServiceError.noJSON)
                    return
                }

                var items = [MLInstallment]()

                for type in costs {
                    if let count = type["installments"] as? Int,
                       let message = type["recommended_message"] as? String,
                       let installmentAmount = type["installment_amount"] as? Double,
                       let totalAmount = type["total_amount"] as? Double {
                        items.append(MLInstallment(count: count, message: message, installmentAmount: "\(installmentAmount)", totalAmount: "\(totalAmount)"))
                    }
                }

                fulfill(items)

            }.catch(policy:.allErrors) {
                error in
                reject(error)
            }

        }

    }

}