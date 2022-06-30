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

    func testGivenAddElementsOneByOne_ThenOperationEnoughElements() {
        let addOperation = ["6", " - ", "2", " x "]

        for part in addOperation {
            calculation.operation.append(part)

            if calculation.elements.count >= 3 && calculation.elements.count % 2 != 0 {
                XCTAssertTrue(calculation.haveEnoughElementsAndInOddNumber)
            }
            else if calculation.elements.count < 3 && calculation.elements.count % 2 == 0  {
                XCTAssertFalse(calculation.haveEnoughElementsAndInOddNumber)
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

    func testGivenFirstNumberIsThree_WhenMultiplySecondNumberIsTwo_ThenResultIsSix() {
        operation("3 x 2", result: 6.0)
    }

    func testGivenFirstNumberIsThree_WhenDivideSecondNumberIsTwo_ThenResultIsOnePointfive() {
        operation("3 ÷ 2", result: 1.5)
    }

    func testGivenFirstNumberIsThree_WhenDivideSecondNumberIsTwoPercent_ThenResultIsFive() {
        operation("3 ÷ 2 %", result: 1.5)
    }

    func testGivenDivideZero_ThenResultError() {
        calculation.operation = "3 ÷ 0"

        calculation.resultEqual()

        XCTAssertEqual(calculation.operation, "Error")
    }

//    func testGivenAnumberIsTwentyFive_WhenAddPercent_ThenResultIsZeroPointTwentyFive() {
////        operation("15 + 25 %", result: 18.75)
//    }

    private func operation(_ operation: String, result: Float) {
        calculation.operation = operation

        calculation.resultEqual()

        XCTAssertEqual(calculation.result, result)
    }

}
