//
// Created by MIGUEL MOLDES on 6/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift


protocol MLUnitProtocol {

    var id : String { get }
    var name : String { get }
    var imagePath : String { get }

}

protocol MLListStepViewModelProtocol : UITableViewDelegate, UITableViewDataSource {

    var list : Variable<[MLUnitProtocol]> { get }

    var buttonEnabled : Variable<Bool> { get }

    var titleText : String { get }

    func getItems()

    func continueTouched()

}

class MLPaymentTypeViewModel : MLPaymentStepViewModel, MLListStepViewModelProtocol {

    var list : Variable<[MLUnitProtocol]>

    var buttonEnabled : Variable<Bool>

    var titleText : String

    override init(flowController: MLFlowControllerProtocol, userPaymentInfo: MLUserPaymentInfo) {
        self.list = Variable<[MLUnitProtocol]>([MLPaymentType]())
        self.buttonEnabled = Variable<Bool>(false)
        self.titleText = "Seleccione el medio de pago"
        super.init(flowController: flowController, userPaymentInfo: userPaymentInfo)
    }

    func getItems() {

        let service = MLService(config: MLGlobalModels.sharedInstance.serviceConfig)
        MLPaymentTypeService(service: service).execute().then {
            types -> Void in

            self.list.value = types

        }.catch(policy: .allErrors) {
            error in
            print(error)
        }
    }

    func continueTouched() {
        self.flowController.goNext(from: .paymentType)
    }

    func selectedRow(unitId: String) {
        self.userPaymentInfo.creditCard = unitId
    }

}

extension MLPaymentTypeViewModel : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MLSelectTypeViewCell,
           let type = cell.paymentType {
            cell.backgroundColor = UIColor.clear
            cell.contentView.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.3)
            self.buttonEnabled.value = true
            self.selectedRow(unitId: type.id)
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
        return self.list.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell!

        let paymentType = self.list.value[(indexPath as NSIndexPath).item]
        cell = tableView.dequeueReusableCell(withIdentifier: "SelectTypeViewCell", for: indexPath) as! MLSelectTypeViewCell

        cell.selectionStyle = .none


        (cell as! MLSelectTypeViewCell).setup(paymentType)
        self.loadImage(cell: cell as! MLSelectTypeViewCell, unitType: paymentType)
        cell.backgroundColor = UIColor.clear

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.blue
        cell.selectedBackgroundView = backgroundView

        return cell
    }

    fileprivate func loadImage(cell: MLSelectTypeViewCell, unitType: MLUnitProtocol) {
        let generation = cell.generation
        let service = MLLoadImageService(service: MLService(config: MLGlobalModels.sharedInstance.serviceConfig))
        MLGlobalModels.sharedInstance.assetsManager.loadImage(path: unitType.imagePath, service: service).then {
            image -> Void in
            guard let icon = cell.iconImageView,
                  cell.generation == generation else {
                return
            }
            guard let image = image else {
                icon.image = nil
                return
            }
            DispatchQueue.main.async {
                icon.image = image
            }
        }.catch(policy: .allErrors) {
            error in
            print (error.localizedDescription)
        }
    }

}