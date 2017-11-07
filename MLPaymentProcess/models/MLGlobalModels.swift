//
// Created by MIGUEL MOLDES on 5/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation

class MLGlobalModels {

    static let sharedInstance = MLGlobalModels()

    let userPaymentInfo : MLUserPaymentInfo
    let flowController : MLFlowController

    private init() {
        self.userPaymentInfo = MLUserPaymentInfo()
        self.flowController = MLFlowController(userPaymentInfo: self.userPaymentInfo)
    }

}