//
// Created by MIGUEL MOLDES on 8/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import PromiseKit

protocol MLPaymentTypeServiceProtocol {

    func execute() -> Promise<[MLPaymentType]>

}
