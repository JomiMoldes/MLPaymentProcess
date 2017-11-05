//
// Created by MIGUEL MOLDES on 5/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation

class MLGlobalModels {

    static let sharedInstance = MLGlobalModels()

    let flowController : MLFlowController!

    private init() {
        self.flowController = MLFlowController()
    }

}