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

extension MLPaymentTypeViewModel : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paymentTypes.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell!
        
        let paymentType = self.paymentTypes.value[(indexPath as NSIndexPath).item]
        cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTypeViewCell", for: indexPath) as! MLPaymentTypeViewCell


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