//
// Created by MIGUEL MOLDES on 5/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class MLInitialViewModel : MLPaymentStepViewModel {

    var buttonEnabled = Variable<Bool>(false)
    var resumeAlert = PublishSubject<UIAlertController>()

    let maxAmountCount : Int = 5

    func viewDidLoad() {
        if self.userPaymentInfo.isCompleted() {
            self.showResume()
        }
    }

    func continueTouched(amount : String) {
        let newString = amount.replacingOccurrences(of: ",", with: ".", options: .literal, range: nil)
        if let amount = Double(newString) {
            self.userPaymentInfo.refresh()
            self.userPaymentInfo.amountToPay = amount
            self.flowController.goNext(from: .initialView)
        }else {
            print("no double amount")
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

    //MARK - Private

    fileprivate func showResume() {
        var error = true
        var message = "Se ha producido un error, por favor intente más tarde"
        if  let resumeMessage = self.userPaymentInfo.installments?.message {
            error = false
            message = resumeMessage
        }

        let alert = UIAlertController(title: "Confirmación de pago", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default)
        alert.addAction(okAction)

        if error == false {
            let cancelAction = UIAlertAction(title: "Cancelar", style: .default)
            alert.addAction(cancelAction)
        }

        self.resumeAlert.onNext(alert)
    }

}
