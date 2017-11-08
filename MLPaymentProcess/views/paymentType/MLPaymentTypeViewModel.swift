//
// Created by MIGUEL MOLDES on 6/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class MLPaymentTypeViewModel : MLPaymentStepViewModel {

    var paymentTypes = Variable<[MLPaymentType]>([MLPaymentType]())

    override init(flowController: MLFlowControllerProtocol, userPaymentInfo: MLUserPaymentInfo) {
        super.init(flowController: flowController, userPaymentInfo: userPaymentInfo)
        self.getPaymentTypes()
    }

    func getPaymentTypes() {

        MLPaymentTypeService().execute().then {
            types -> Void in

            self.paymentTypes.value = types

        }.catch(policy: .allErrors) {
            error in
            print(error)
        }
    }

}

extension MLPaymentTypeViewModel : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paymentTypes.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell!
        let paymentType = self.paymentTypes.value[(indexPath as NSIndexPath).item]
        cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTypeViewCell", for: indexPath) as! MLPaymentTypeViewCell
        (cell as! MLPaymentTypeViewCell).setup(paymentType)
        cell.backgroundColor = UIColor.clear

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.blue
        cell.selectedBackgroundView = backgroundView

        return cell
    }

}