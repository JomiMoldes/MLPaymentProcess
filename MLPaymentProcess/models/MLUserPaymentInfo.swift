//
// Created by MIGUEL MOLDES on 5/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation

class MLUserPaymentInfo {

    var amountToPay = 0.0
    var creditCard = ""
    var bank = ""
    var installments : MLInstallment?

    func isCompleted() -> Bool {
        if self.amountToPay > 0 &&
                self.creditCard != "" &&
                self.bank != "" &&
                installments != nil {
            return true
        }
        return false
    }

    func refresh() {
        self.amountToPay = 0.0
        self.creditCard = ""
        self.bank = ""
        self.installments = nil
    }

}