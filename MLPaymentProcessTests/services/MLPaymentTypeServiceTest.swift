//
// Created by MIGUEL MOLDES on 8/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import OHHTTPStubs
import XCTest

@testable import MLPaymentProcess

class MLPaymentTypeServiceTest : XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testExecute() {

        stub(condition: isHost("api.mercadopago.com")) {
            response in

            let path = OHPathForFile("paymentType.json", type(of: self))
            return OHHTTPStubsResponse(fileAtPath: path!, statusCode: 200, headers: ["Content-Type":"application/json"])
        }

        let expect = expectation(description: "MLPaymentTypeService")

        let service = MLService(config: MLGlobalModels.sharedInstance.serviceConfig)
        MLPaymentTypeService(service: service).execute().then {
            types -> Void in


            XCTAssertEqual(types.count, 3)
            XCTAssertEqual(types[1].name, "Mastercard")
            XCTAssertEqual(types[1].imagePath, "http://img.mlstatic.com/org-img/MP3/API/logos/master.gif")

            expect.fulfill()

        }.catch(policy: .allErrors) {
            error in
            XCTFail("MLPaymentTypeServiceTest - execute")
        }

        waitForExpectations(timeout: 10.0)

    }

}