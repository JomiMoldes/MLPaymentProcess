//
// Created by MIGUEL MOLDES on 8/11/17.
// Copyright (c) 2017 MIGUEL MOLDES. All rights reserved.
//

import Foundation
import XCTest
import OHHTTPStubs

@testable import MLPaymentProcess

class MLServiceTest : XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testRequest() {

        stub(condition: isHost("api.mercadopago.com")) {
            response in
            let path = OHPathForFile("paymentType.json", type(of: self))
            return OHHTTPStubsResponse(fileAtPath: path!, statusCode: 200, headers: ["Content-Type":"application/json"])
        }

        let config = MLGlobalModels.sharedInstance.serviceConfig
        let service = MLService(config: config)
        let request = MLRequest(requestType: .get, path: "lala")

        let expect = expectation(description: "service")

        service.execute(request, nil).then {
            response -> Void in

            XCTAssertTrue(response.result.isSuccess)
            expect.fulfill()
        }.catch(policy: .allErrors) {
            error in
            XCTFail("MLServiceTest - testRequest")
        }

        waitForExpectations(timeout: 1.0)
    }

}
