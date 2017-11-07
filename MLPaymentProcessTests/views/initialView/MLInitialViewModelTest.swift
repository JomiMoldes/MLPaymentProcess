//
// Created by MIGUEL MOLDES on 6/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import XCTest

@testable import MLPaymentProcess

class MLInitialViewModelTest : XCTestCase {

    var sut : MLInitialViewModel!
    var flowController : MLFlowControllerFake!
    var userInfo : MLUserPaymentInfo!

    override func setUp() {
        super.setUp()
        self.userInfo = MLUserPaymentInfo()
        self.flowController = MLFlowControllerFake(userPaymentInfo: self.userInfo)
        self.createSUT()
    }

    func testInitialization() {
        XCTAssertNotNil(self.sut.flowController)
    }

    func testContinuePressed() {
        let navController = self.flowController.navController as! MLNavigationControllerMock
        let tf = self.createTextField()
        tf.text = "12.68"

        self.sut.continueTouched(amount: "")
        XCTAssertEqual(navController.lastViewController?.nibName, "MLInitialView")
        XCTAssertEqual(0.0, self.userInfo.amountToPay)

        self.sut.continueTouched(amount: tf.text!)
        XCTAssertEqual(navController.lastViewController?.nibName, "MLPaymentTypeView")
        XCTAssertEqual(12.68, self.userInfo.amountToPay)

    }

    func testAmountIsValid() {
        let tf = self.createTextField()
        var newText = ""
        tf.text = ""

        XCTAssertTrue(self.sut.amountIsValid(textField: tf, text: newText))

        tf.text = "12345678"
        newText = "1"
        XCTAssertFalse(self.sut.amountIsValid(textField: tf, text: newText))
        tf.text = ""
        newText = "a"
        XCTAssertFalse(self.sut.amountIsValid(textField: tf, text: newText))
        tf.text = "."
        newText = "."
        XCTAssertFalse(self.sut.amountIsValid(textField: tf, text: newText))
        tf.text = "."
        newText = ","
        XCTAssertFalse(self.sut.amountIsValid(textField: tf, text: newText))
        tf.text = ","
        newText = "."
        XCTAssertFalse(self.sut.amountIsValid(textField: tf, text: newText))
        tf.text = ","
        newText = ","
        XCTAssertFalse(self.sut.amountIsValid(textField: tf, text: newText))
        tf.text = ""
        newText = "."
        XCTAssertFalse(self.sut.amountIsValid(textField: tf, text: newText))
        tf.text = ""
        newText = ","
        XCTAssertFalse(self.sut.amountIsValid(textField: tf, text: newText))
        tf.text = "2"
        newText = "f"
        XCTAssertFalse(self.sut.amountIsValid(textField: tf, text: newText))
        tf.text = "2.2"
        newText = "."
        XCTAssertFalse(self.sut.amountIsValid(textField: tf, text: newText))
        tf.text = "2."
        newText = "."
        XCTAssertFalse(self.sut.amountIsValid(textField: tf, text: newText))
    }

    func testTextHasChanged() {
        let tf = self.createTextField()
        self.sut.textHasChanged(textField: tf)
        XCTAssertFalse(self.sut.buttonEnabled.value)

        tf.text = "1"
        self.sut.textHasChanged(textField: tf)
        XCTAssertTrue(self.sut.buttonEnabled.value)

        tf.text = ""
        self.sut.textHasChanged(textField: tf)
        XCTAssertFalse(self.sut.buttonEnabled.value)

    }

    func testTextFieldAllowPrice() {
        let tf = self.createTextField()
        tf.text = "1.11"
        XCTAssertFalse(tf.allowAppendStringForPrice("1", maxLength: 5, maxDecimals: 2))

        tf.text = "1.11"
        XCTAssertTrue(tf.allowAppendStringForPrice("1", maxLength: 5, maxDecimals: 3))

        tf.text = "12345"
        XCTAssertTrue(tf.allowAppendStringForPrice("1", maxLength: 6, maxDecimals: 2))

        tf.text = "12345"
        XCTAssertFalse(tf.allowAppendStringForPrice("1", maxLength: 5, maxDecimals: 2))

        tf.text = "12345"
        XCTAssertTrue(tf.allowAppendStringForPrice(".", maxLength: 5, maxDecimals: 2))

        tf.text = "1234."
        XCTAssertFalse(tf.allowAppendStringForPrice(".", maxLength: 5, maxDecimals: 2))

        tf.text = "12.2"
        XCTAssertFalse(tf.allowAppendStringForPrice(".", maxLength: 5, maxDecimals: 2))

        tf.text = "12.2"
        XCTAssertFalse(tf.allowAppendStringForPrice("a", maxLength: 5, maxDecimals: 2))
        
    }

    //MARK - Private

    fileprivate func createSUT() {
        self.sut = MLInitialViewModel(flowController : self.flowController, userPaymentInfo: self.userInfo)
        self.flowController.setup(vc: createFirstView())
    }

    fileprivate func createFirstView() -> MLInitialViewController {
        let initialViewController = MLInitialViewController(nibName: "MLInitialView", bundle: nil)
        initialViewController.initialView.model = self.sut
        return initialViewController
    }

    fileprivate func createTextField() -> UITextField {
        let tf = UITextField(frame: CGRect(x:0, y:0, width: 100, height:100))
        return tf
    }

    fileprivate func getButton() -> UIButton {
        return UIButton(frame: CGRect(x:0,y:0,width:100,height:100))
    }
}