//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Gregory Deveaux on 19/06/2022.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {

    var calculateWithOperator: CalculateWithOperator!

        //SetUp for all tests
    override func setUp() {
        super.setUp()
        calculateWithOperator = CalculateWithOperator()
    }

    override func tearDown() {
        super.tearDown()

    }

    func testGivenInstanceOfCalculateWithOperator_WhenAccessingIt_ThenItExists() {
        XCTAssertNotNil(calculateWithOperator)
    }

    func testGivenFirstNumberIsThree_WhenAddSecondNumberIsTwo_ThenResultIsFive() {

    }

}
