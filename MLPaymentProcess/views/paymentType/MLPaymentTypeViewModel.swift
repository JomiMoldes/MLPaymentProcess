//
// Created by MIGUEL MOLDES on 6/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation

class MLPaymentTypeViewModel {

    weak var flowController : MLFlowControllerProtocol!

    init(flowController : MLFlowControllerProtocol) {
        self.flowController = flowController
    }

}