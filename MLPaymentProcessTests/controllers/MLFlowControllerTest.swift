//
// Created by MIGUEL MOLDES on 6/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import XCTest

@testable import MLPaymentProcess

class MLFlowControllerTest : XCTestCase {

    var sut : MLFlowControllerFake!
    var navController : MLNavigationControllerMock!

    override func setUp() {
        super.setUp()
        self.createSUT()
        self.sut.addFirstView()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFirstView() {
        XCTAssertEqual("MLInitialView", (self.navController.lastViewController?.nibName)!)
    }

    fileprivate func createSUT() {
        self.sut = MLFlowControllerFake()
        self.navController = MLNavigationControllerMock(rootViewController: self.createFirstView())
    }

    fileprivate func createFirstView() -> MLInitialViewController {
        let initialViewController = MLInitialViewController(nibName: "MLInitialView", bundle: nil)
        initialViewController.initialView.model = MLInitialViewModel(flowController: self.sut)
        return initialViewController
    }

    
}

class MLFlowControllerFake : MLFlowController {

    /*override func addFirstView() {
        self.navController = MLNavigationControllerMock(rootViewController: self.createFirstView())
    }

    fileprivate func createFirstView() -> MLInitialViewController {
        let initialViewController = MLInitialViewController(nibName: "MLInitialView", bundle: nil)
        initialViewController.initialView.model = MLInitialViewModel(flowController: self)
        return initialViewController
    }*/

}
