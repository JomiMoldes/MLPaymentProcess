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

    override func setUp() {
        super.setUp()
        self.flowController = MLFlowControllerFake()
        self.createSUT()
    }

    func testInitialization() {
        XCTAssertNotNil(self.sut.flowController)
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
        self.sut = MLInitialViewModel(flowController : self.flowController)
    }

    fileprivate func createTextField() -> UITextField {
        let tf = UITextField(frame: CGRect(x:0, y:0, width: 100, height:100))
        return tf
    }
}