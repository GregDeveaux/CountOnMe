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

        XCTAssertFalse(calculation.operationIsCurrentlyCorrect)
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

    func testGivenThreeAddThree_WhenMultiplyByThree_ThenResultIsTwelve() {
        operation("3 + 3 x 3", result: 12)
    }

    func testGivenThreeAddThree_WhenDivideByThree_ThenResultIsFour() {
        operation("3 + 3 ÷ 3", result: 4)
    }

    func testGivenDivideZero_ThenResultError() {
        verifyEqualSomething(operation: "3 ÷ 0", something: "Error: impossible divise by 0")
    }

    func testGivenResultEqual_ThenIsTrue() {
        calculation.operation = "6 + 6 = "

        XCTAssertTrue(calculation.canActiveResultEqual)
    }

        // MARK: - Test point of the decimal
    func testGivenTwoDecimalInTheSameNumber_ThenIsFalse() {
        calculation.operation = "6.."

        XCTAssertFalse(calculation.addPointDecimalIsCorrect)
    }

    func testGivenNumberSixWithDecimalWithoutNextNumber_WhenAddOperand_ThenIsFalse() {
        calculation.operation = "6. +"

        XCTAssertFalse(calculation.operationIsCurrentlyCorrect)
    }

    func testGivenNumberSixWithOperand_WhenAddDecimalPoint_ThenIsFalse() {
        calculation.operation = "6 + ."

        XCTAssertFalse(calculation.operationIsCurrentlyCorrect)
    }


        // MARK: - Test infinity number
    func testGivenBigOperation_ThenISInfinity() {
        verifyEqualSomething(operation: "66 x 6699999999999999999999999999999999999999999 x 6", something: "to infinity and beyond")
    }


        // MARK: - Test Percent
    func testGivenAnumberIs1020_WhenAdd29Percent_ThenResultIs1315Point8() {
        operation("1020 + 29%", result: 1315.8)
    }

    func testGivenAnumberIs1020_WhenSubstract29Percent_ThenResultIs1315Point8() {
        operation("1020 - 29%", result: 724.2)
    }

    func testGivenAnumberIs5_WhenMultiply5Percent_ThenResultIs0Point25() {
        operation("5 x 5%", result: 0.25)
    }

    func testGivenAnumberIs5_WhenDivide25Percent_ThenResultIs20() {
        operation("5 ÷ 25%", result: 20)
    }

    func testGivenAnumberIs29Percent_ThenResultIs0Point29() {
        operation("29%", result: 0.29)
    }

        // MARK: - calibrate an operation for test
    private func operation(_ operation: String, result: Double) {
        calculation.operation = operation

        calculation.resultEqual()

        XCTAssertEqual(calculation.result, result)
    }

    private func verifyEqualSomething(operation: String, something: String) {
        calculation.operation = operation

        calculation.resultEqual()

        XCTAssertEqual(calculation.operation, something)
    }
}
