//
// Created by MIGUEL MOLDES on 5/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit

class MLFlowController {

    fileprivate (set) var navController : UINavigationController!

    init() {

    }

    func addFirstView() {
        self.navController = UINavigationController(rootViewController: self.createInitialVC())
    }

    func goNext(from : FlowView) {

        var vc : UIViewController!

        switch from {
            case .initialView:
                //vc = MLInitialViewController(nibName: "MLInitialView", bundle: nil)
            break
            case .paymentType:

            break
            case .bank:

            break
            case .installments:
                vc = self.createInitialVC()
            break
        }

        self.navController.pushViewController(vc, animated: true)
    }

    fileprivate func createInitialVC() -> MLInitialViewController {
        let initialViewController = MLInitialViewController(nibName: "MLInitialView", bundle: nil)
        initialViewController.initialView.model = MLInitialViewModel()
        return initialViewController
    }


}

enum FlowView : String {
    case initialView
    case paymentType
    case bank
    case installments
}