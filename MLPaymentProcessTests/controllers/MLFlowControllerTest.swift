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
    var userInfo : MLUserPaymentInfo!

    override func setUp() {
        super.setUp()
        self.createSUT()
//        self.sut.addFirstView()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFirstView() {
        XCTAssertEqual("MLInitialView", (self.getNavController().lastViewController?.nibName)!)
    }

    fileprivate func createSUT() {
        self.userInfo = MLUserPaymentInfo()
        self.sut = MLFlowControllerFake(userPaymentInfo: self.userInfo)
        self.sut.setup(vc: self.createFirstView())
    }

    fileprivate func createFirstView() -> MLInitialViewController {
        let initialViewController = MLInitialViewController(nibName: "MLInitialView", bundle: nil)
        initialViewController.initialView.model = MLInitialViewModel(flowController: self.sut, userPaymentInfo: self.userInfo)
        return initialViewController
    }

    fileprivate func getNavController() -> MLNavigationControllerMock {
        return self.sut.navController as! MLNavigationControllerMock
    }

    
}

class MLFlowControllerFake : MLFlowController {

    func setup(vc : UIViewController) {
        self.navController = MLNavigationControllerMock(rootViewController: vc)
    }

    /*override func addFirstView() {
        self.navController = MLNavigationControllerMock(rootViewController: self.createFirstView())
    }

    fileprivate func createFirstView() -> MLInitialViewController {
        let initialViewController = MLInitialViewController(nibName: "MLInitialView", bundle: nil)
        initialViewController.initialView.model = MLInitialViewModel(flowController: self)
        return initialViewController
    }*/

}
