//
// Created by MIGUEL MOLDES on 6/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import UIKit
import XCTest

class MLNavigationControllerMock: UINavigationController {

    var lastViewController : UIViewController?
    var lastAlertController : UIViewController?

    var asyncExpectation : XCTestExpectation?
    var pushExpectation : XCTestExpectation?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        lastViewController = viewController
        pushExpectation?.fulfill()
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        lastViewController = nil

        guard let expectation = asyncExpectation else {
            XCTFail("missing expectation")
            return super.popViewController(animated: false)
        }

        expectation.fulfill()

        return super.popViewController(animated: false)
    }

}