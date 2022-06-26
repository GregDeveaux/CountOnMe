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

    func testGivenOneNumberOrOneOperand_WhenAddOtherThing_ThenOperationEnoughElements() {
        let addOperation = ["6", " - ", "2", " x "]

        for part in addOperation {
            calculation.operation.append(part)

            if calculation.operation.count % 2 == 0 || calculation.operation.count < 3{
                XCTAssertFalse(calculation.haveEnoughElements)
            } else {
                XCTAssertTrue(calculation.haveEnoughElements)
            }
        }
    }


    func testGivenOperation_WhenAddEqual_ThenOperationIsCompleted() {
        calculation.operation = "6.9 / 3.68"
        calculation.operation.append(" = ")

        XCTAssertTrue(calculation.canActiveResultEqual)
    }

    func testGivenOneNumberAndOneOperand_WhenAddSecondOperand_ThenResultIsFalse() {
        calculation.operation = "6.9 / "
        let operands = [" + ", " - ", " x ", " ÷ "]

        for operand in operands {
            calculation.operation.append(operand)
        }

        XCTAssertFalse(calculation.canAddOperator)
    }

    func testGivenAddition_WhenActivateEqualResult_ThenResultIsFive() {
        operation("3 + 2", result: 5.0)
    }

    func testGivenSubstraction_WhenActivateEqualResult_ThenResultIsOne() {
        operation("3 - 2", result: 1.0)
    }

    func testGivenFirstNumberIsThree_WhenMultiplySecondNumberIsTwo_ThenResultIsFive() {
        operation("3 x 2", result: 6.0)
    }

    func testGivenFirstNumberIsThree_WhenDivideSecondNumberIsTwo_ThenResultIsFive() {
        operation("3 ÷ 2", result: 1.5)
    }

    private func operation(_ operation: String, result: Float) {
        calculation.operation = operation

        calculation.resultEqual()

        XCTAssertEqual(calculation.result, result)
    }

}
