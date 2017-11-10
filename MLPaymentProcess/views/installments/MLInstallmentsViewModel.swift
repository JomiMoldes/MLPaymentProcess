//
// Created by MIGUEL MOLDES on 9/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MLInstallmentsViewModel : MLPaymentStepViewModel, MLListStepViewModelProtocol {

    var list : Variable<[MLUnitProtocol]>

    var buttonEnabled : Variable<Bool>

    var titleText : String

    override init(flowController: MLFlowControllerProtocol, userPaymentInfo: MLUserPaymentInfo) {
        self.list = Variable<[MLUnitProtocol]>([MLInstallment]())
        self.titleText = "Seleccione la cantidad de cuotas deseada"
        self.buttonEnabled = Variable<Bool>(false)
        super.init(flowController: flowController, userPaymentInfo: userPaymentInfo)
        NotificationCenter.default.addObserver(self, selector: #selector(goBack(notification:)), name: Notification.Name("backButtonPressed"), object: nil)
    }

    func getItems() {
        let service = MLService(config: MLGlobalModels.sharedInstance.serviceConfig)
        MLInstallmentsService(service:service, userInfo: self.userPaymentInfo).execute().then {
            installments in

            self.list.value = installments

        }.catch(policy: .allErrors) {
            error in
            print(error)
        }
    }

    func setupTable(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName:"MLInstallmentViewCell", bundle:nil), forCellReuseIdentifier: "InstallmentViewCell")
    }

    func continueTouched() {
        self.flowController.goNext(from: .installments)
    }

    func selectedRow(installment: MLInstallment) {
        self.userPaymentInfo.installments = installment
    }
    
    @objc func goBack(notification: Notification) {
        self.userPaymentInfo.installments = nil
    }
}

extension MLInstallmentsViewModel : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MLInstallmentViewCell,
           let installment = cell.installment {
            cell.backgroundColor = UIColor.clear
            cell.contentView.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.3)
            self.buttonEnabled.value = true
            self.selectedRow(installment: installment)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.white
        }
    }

}

extension MLInstallmentsViewModel : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MLInstallmentViewCell!

        let installmentSelected = self.list.value[(indexPath as NSIndexPath).item]
        cell = tableView.dequeueReusableCell(withIdentifier: "InstallmentViewCell", for: indexPath) as! MLInstallmentViewCell

        cell.selectionStyle = .none


        cell.setup(installmentSelected as! MLInstallment)
        cell.backgroundColor = UIColor.clear

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.blue
        cell.selectedBackgroundView = backgroundView

        return cell
    }

}
