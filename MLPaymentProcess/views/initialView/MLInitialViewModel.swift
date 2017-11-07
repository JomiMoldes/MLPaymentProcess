//
// Created by MIGUEL MOLDES on 5/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class MLInitialViewModel : MLPaymentStepViewModel {

    var buttonEnabled = Variable<Bool>(false)

    let maxAmountCount : Int = 5

    func continueTouched(amount : String) {
        if let amount = Double(amount) {
            self.userPaymentInfo.amountToPay = amount
            self.flowController.goNext(from: .initialView)
        }
    }

    func amountIsValid(textField : UITextField, text : String) -> Bool {
        let result = textField.allowAppendStringForPrice(text, maxLength: self.maxAmountCount)
        return result
    }

    func textHasChanged(textField : UITextField) {
        if let text = textField.text,
           text.count > 0 {
            self.buttonEnabled.value = true
            return
        }
        self.buttonEnabled.value = false
    }

}