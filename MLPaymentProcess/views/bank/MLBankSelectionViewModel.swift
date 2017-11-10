//
// Created by MIGUEL MOLDES on 8/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class MLBankSelectionViewModel : MLPaymentTypeViewModel {

    override init(flowController: MLFlowControllerProtocol, userPaymentInfo: MLUserPaymentInfo) {
        super.init(flowController: flowController, userPaymentInfo: userPaymentInfo)
        self.list = Variable<[MLUnitProtocol]>([MLBank]())
        self.titleText = "Seleccione su banco"
    }


    override func getItems() {
        let service = MLService(config: MLGlobalModels.sharedInstance.serviceConfig)
        MLBankService(service: service, userInfo: self.userPaymentInfo).execute().then {
            banks -> Void in

            self.list.value = banks

        }.catch(policy: .allErrors) {
            error in
            print(error)
        }

    }

    override func continueTouched() {
        self.flowController.goNext(from: .bank)
    }

    override func selectedRow(unitId: String) {
        self.userPaymentInfo.bank = unitId
    }
    
    @objc override func goBack(notification: Notification) {
        self.userPaymentInfo.bank = ""
    }

}
