//
// Created by MIGUEL MOLDES on 7/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import PromiseKit

class MLPaymentStepViewModel : NSObject {

    let flowController : MLFlowControllerProtocol

    var userPaymentInfo : MLUserPaymentInfo!

    init(flowController : MLFlowControllerProtocol, userPaymentInfo: MLUserPaymentInfo) {
        self.flowController = flowController
        self.userPaymentInfo = userPaymentInfo
    }

}