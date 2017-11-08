//
// Created by MIGUEL MOLDES on 5/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation

class MLGlobalModels {

    static let sharedInstance = MLGlobalModels()

    let userPaymentInfo : MLUserPaymentInfo
    let flowController : MLFlowController
    fileprivate (set) var serviceConfig : MLServiceConfig
    let assetsManager : MLAssetsManager

    private init() {
        self.userPaymentInfo = MLUserPaymentInfo()
        self.flowController = MLFlowController(userPaymentInfo: self.userPaymentInfo)
        self.serviceConfig = MLServiceConfig(name: "MLPayments", path: "https://api.mercadopago.com/v1/")
        self.assetsManager = MLAssetsManager()
    }

    func addNewServieConfig(config: MLServiceConfig) {
        self.serviceConfig = config
    }

}