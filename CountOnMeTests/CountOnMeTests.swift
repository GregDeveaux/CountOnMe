//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Gregory Deveaux on 19/06/2022.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {

    func testGivenInstanceOfCalculateWithOperator_WhenAccessingIt_ThenItExists() {
        let calculateWithOperator = CalculateWithOperator()
        XCTAssertNotNil(calculateWithOperator)
    }



}
