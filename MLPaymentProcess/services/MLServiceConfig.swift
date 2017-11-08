//
// Created by MIGUEL MOLDES on 7/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation

struct MLServiceConfig {

    let name:String
    let path:String

    static let KEY = "444a9ef5-8a6b-429f-abdf-587639155d88"
    static let paymentType = "payment_methods?public_key=\(MLServiceConfig.KEY)"

}