//
//  CountOnMeUITest.swift
//  CountOnMeUITest
//
//  Created by Greg-Mini on 10/07/2022.
//  Copyright © 2022 Gregory Deveaux. All rights reserved.
//

import XCTest

class CountOnMeUITest: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()

        continueAfterFailure = false
    }

    func testFivePlusFiveEqualTen() throws {
        let staticTextFive = app/*@START_MENU_TOKEN@*/.buttons["5"].staticTexts["5"]/*[[".buttons[\"5\"].staticTexts[\"5\"]",".staticTexts[\"5\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        staticTextFive.tap()
        app/*@START_MENU_TOKEN@*/.buttons["+"].staticTexts["+"]/*[[".buttons[\"+\"].staticTexts[\"+\"]",".staticTexts[\"+\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        staticTextFive.tap()
        app.buttons["="].tap()
        app.textViews.containing(.staticText, identifier:"5 + 5 = 10")
    }

    func testSixPointNinetyEightSevenFourThreeTwoSubstractTenPercent() throws {
        app/*@START_MENU_TOKEN@*/.staticTexts["6"]/*[[".buttons[\"6\"].staticTexts[\"6\"]",".staticTexts[\"6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["."]/*[[".buttons[\".\"].staticTexts[\".\"]",".staticTexts[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["9"]/*[[".buttons[\"9\"].staticTexts[\"9\"]",".staticTexts[\"9\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["8"]/*[[".buttons[\"8\"].staticTexts[\"8\"]",".staticTexts[\"8\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["7"]/*[[".buttons[\"7\"].staticTexts[\"7\"]",".staticTexts[\"7\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["4"]/*[[".buttons[\"4\"].staticTexts[\"4\"]",".staticTexts[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["3"]/*[[".buttons[\"3\"].staticTexts[\"3\"]",".staticTexts[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["2"]/*[[".buttons[\"2\"].staticTexts[\"2\"]",".staticTexts[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["–"]/*[[".buttons[\"–\"].staticTexts[\"–\"]",".staticTexts[\"–\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["1"]/*[[".buttons[\"1\"].staticTexts[\"1\"]",".staticTexts[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["0"]/*[[".buttons[\"0\"].staticTexts[\"0\"]",".staticTexts[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["%"]/*[[".buttons[\"%\"].staticTexts[\"%\"]",".staticTexts[\"%\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textViews.containing(.staticText, identifier:"6.987432 - 10% = 6.2886887")
    }

    func testAllOperands() throws {
        app.buttons["6"].tap()
        app.buttons["÷"].tap()
        app.buttons["2"].tap()
        app.buttons["x"].tap()
        app.buttons["9"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["–"]/*[[".buttons[\"–\"].staticTexts[\"–\"]",".staticTexts[\"–\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["6"].tap()
        app.buttons["+"].tap()
        app.buttons["1"].tap()
        app.buttons["="].tap()
        app.textViews.containing(.staticText, identifier:"6 ÷ 2 x 9 - 6 + 1 = -4.6666665")
    }

    func testAC() throws {
        app.buttons["6"].tap()
        app.buttons["÷"].tap()
        app.buttons["2"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["AC"]/*[[".buttons[\"AC\"].staticTexts[\"AC\"]",".staticTexts[\"AC\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textViews.containing(.staticText, identifier:"0")
    }

    func testAlertDoublePoint() throws {
        app.buttons["8"].tap()

        let buttonPoint = app.buttons["."]
        buttonPoint.tap()
        buttonPoint.tap()

        scrollViewQuery(result: "8.")
    }

    func testAlertDoubleOperands() throws {
        app.buttons["9"].tap()
        app.buttons["÷"].tap()
        app.buttons["+"].tap()

        scrollViewQuery(result: "9 ÷ ")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    private func scrollViewQuery(result: String) {
        let scrollViewsQuery = app.alerts["Attention!"].scrollViews
        scrollViewsQuery.otherElements.buttons["OK"].tap()
        app.textViews.containing(.staticText, identifier:"result")
    }
}
