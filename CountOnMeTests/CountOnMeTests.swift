//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Gregory Deveaux on 19/06/2022.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {

    var calculation: Calculation!

        //SetUp for all tests
    override func setUp() {
        super.setUp()
        calculation = Calculation()
    }

    override func tearDown() {
        super.tearDown()

    }

    func testGivenInstanceOfCalculateWithOperator_WhenAccessingIt_ThenItExists() {
        XCTAssertNotNil(calculation)
    }

    func testGivenFirstNumberIsThree_WhenAddSecondNumberIsTwo_ThenResultIsFive() {
        // Given
        calculation.calculationTapped = "3 + 2"

        XCTAssertEqual(calculation.calculationResult, 5)

    }

}
