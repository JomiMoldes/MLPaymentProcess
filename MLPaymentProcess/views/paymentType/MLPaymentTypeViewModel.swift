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

    var buttonEnabled = Variable<Bool>(false)

    override init(flowController: MLFlowControllerProtocol, userPaymentInfo: MLUserPaymentInfo) {
        super.init(flowController: flowController, userPaymentInfo: userPaymentInfo)
        self.getPaymentTypes()
    }

    func getPaymentTypes() {

        let service = MLService(config: MLGlobalModels.sharedInstance.serviceConfig)
        MLPaymentTypeService(service: service).execute().then {
            types -> Void in

            self.paymentTypes.value = types

        }.catch(policy: .allErrors) {
            error in
            print(error)
        }
    }

    func continueTouched() {
        print("touched")
    }

}

extension MLPaymentTypeViewModel : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MLPaymentTypeViewCell,
           let type = cell.paymentType {
            cell.backgroundColor = UIColor.clear
            cell.contentView.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.3)
            self.buttonEnabled.value = true
            self.userPaymentInfo.creditCard = type.name
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.white
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

        cell.selectionStyle = .none


        (cell as! MLPaymentTypeViewCell).setup(paymentType)
        self.loadImage(cell: cell as! MLPaymentTypeViewCell, paymentType: paymentType)
        cell.backgroundColor = UIColor.clear

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.blue
        cell.selectedBackgroundView = backgroundView

        return cell
    }

    fileprivate func loadImage(cell: MLPaymentTypeViewCell, paymentType: MLPaymentType) {
        let generation = cell.generation
        let service = MLLoadImageService(service: MLService(config: MLGlobalModels.sharedInstance.serviceConfig))
        MLGlobalModels.sharedInstance.assetsManager.loadImage(path: paymentType.imagePath, service: service).then {
            image -> Void in
            guard cell.generation == generation else {
                return
            }
            DispatchQueue.main.async {
                if let icon = cell.iconImageView {
                    icon.image = image
                }
            }
        }.catch(policy: .allErrors) {
            error in
            print (error.localizedDescription)
        }
    }

}