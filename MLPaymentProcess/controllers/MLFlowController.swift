//
// Created by MIGUEL MOLDES on 5/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit

class MLFlowController : MLFlowControllerProtocol {

    var navController : UINavigationController!
    let userPaymentInfo : MLUserPaymentInfo

    var currentVCName : String = ""

    init(userPaymentInfo: MLUserPaymentInfo) {
        self.userPaymentInfo = userPaymentInfo
        NotificationCenter.default.addObserver(self, selector: #selector(goBack(notification:)), name: Notification.Name("backButtonPressed"), object: nil)
    }

    func addFirstView() {
        self.navController = UINavigationController(rootViewController: self.createInitialVC())
    }

    func goNext(from : FlowView) {

        var vc : UIViewController!

        switch from {
            case .initialView:

                vc = MLSelectTypeViewController(nibName: "MLSelectTypeView", bundle: nil)
                let viewModel = self.createPaymentTypeViewModel()
                (vc as! MLSelectTypeViewController).customView.model = viewModel
                viewModel.getItems()
                self.currentVCName = "PaymentType"

            break
            case .paymentType:

                vc = MLSelectTypeViewController(nibName: "MLSelectTypeView", bundle: nil)
                let viewModel = self.createBankViewModel()
                (vc as! MLSelectTypeViewController).customView.model = viewModel
                viewModel.getItems()

                self.currentVCName = "Banks"

            break
            case .bank:

                vc = MLSelectTypeViewController(nibName: "MLSelectTypeView", bundle: nil)
                let viewModel = self.createInstallmentsViewModel()
                (vc as! MLSelectTypeViewController).customView.model = viewModel
                viewModel.getItems()

                self.currentVCName = "Installments"

            break
            case .installments:
                vc = self.createInitialVC()

                self.currentVCName = "Initial"
            break
        }

        self.navController.pushViewController(vc, animated: true)
    }

    @objc func goBack(notification: Notification) {
        self.navController.popViewController(animated: true)
    }

    func createInstallmentsViewModel() -> MLInstallmentsViewModel {
        return MLInstallmentsViewModel(flowController: self, userPaymentInfo: self.userPaymentInfo)
    }

    func createPaymentTypeViewModel() -> MLPaymentTypeViewModel {
        return MLPaymentTypeViewModel(flowController: self, userPaymentInfo: self.userPaymentInfo)
    }

    func createBankViewModel() -> MLBankSelectionViewModel {
        return MLBankSelectionViewModel(flowController: self, userPaymentInfo: self.userPaymentInfo)
    }

    private func createInitialVC() -> MLInitialViewController {
        let initialViewController = MLInitialViewController(nibName: "MLInitialView", bundle: nil)
        initialViewController.initialView.model = MLInitialViewModel(flowController: self, userPaymentInfo: self.userPaymentInfo)
        return initialViewController
    }

}

enum FlowView : String {
    case initialView
    case paymentType
    case bank
    case installments
}

protocol MLFlowControllerProtocol : class {

    func goNext(from : FlowView)

}