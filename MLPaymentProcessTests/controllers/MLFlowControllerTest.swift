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
    }

    override func tearDown() {
        super.tearDown()
        self.navController = nil
        self.sut = nil
    }

    func testFirstView() {
        XCTAssertEqual("MLInitialView", (self.getNavController().lastViewController?.nibName)!)
    }

    func testGoNext() {

        self.sut.goNext(from: .initialView)
        XCTAssertEqual("MLSelectTypeView", (self.getNavController().lastViewController?.nibName)!)

        XCTAssertEqual("PaymentType", self.sut.currentVCName)

        self.sut.goNext(from: .paymentType)
        XCTAssertEqual("MLSelectTypeView", (self.getNavController().lastViewController?.nibName)!)
        XCTAssertEqual("Banks", self.sut.currentVCName)
        
        self.sut.goNext(from: .bank)
        XCTAssertEqual("MLSelectTypeView", (self.getNavController().lastViewController?.nibName)!)
        XCTAssertEqual("Installments", self.sut.currentVCName)
    }

    func testGoBack() {
        self.sut.goNext(from: .bank)

        XCTAssertNotNil(self.getNavController().lastViewController)

        let nav = self.getNavController()
        nav.asyncExpectation = expectation(description: "popViewController")

        NotificationCenter.default.post(name: Notification.Name("backButtonPressed"), object: nil)

        waitForExpectations(timeout: 10.0) {
            error in
            if error != nil {
                XCTFail("no viewcontroller poped")
                return
            }
            XCTAssertNil(self.getNavController().lastViewController)
        }

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

    override func createInstallmentsViewModel() -> MLInstallmentsViewModel {
        return MLSInstallmentsViewModelFake(flowController: self, userPaymentInfo: self.userPaymentInfo)
    }

    override func createPaymentTypeViewModel() -> MLPaymentTypeViewModel {
        return MLPaymentTypeViewModelFake(flowController: self, userPaymentInfo: self.userPaymentInfo)
    }

    override func createBankViewModel() -> MLBankSelectionViewModel {
        return MLBankViewModelFake(flowController: self, userPaymentInfo: self.userPaymentInfo)
    }

}
