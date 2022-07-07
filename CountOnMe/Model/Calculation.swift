//
//  CalculateWithOperator.swift
//  CountOnMe
//
//  Created by Gregory Deveaux on 19/06/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum State {
    case isProgress, isOver
}

class Calculation {

        //MARK: - init calculation

        // create the string of the operation
    var operation: String = "0"

        // we don't used other characters for the operation
    let validNumbers = CharacterSet(charactersIn: "0123456789%")
    let validOperands = CharacterSet(charactersIn: "-+x÷.=")

    var state: State = .isOver

        // the operation is separate into several values due to space
    var elements: [String] {
        return operation.split(separator: " ").map { "\($0)" }
    }

    var result: Float = 0

    var index = 0

        //MARK: - verify actions

        // verify than the operation contains what's needed
    var haveEnoughElementsAndInOddNumber: Bool {
        return elements.count >= 3 && elements.count % 2 != 0
    }

        // add an operator if there is none
    var operationIsCurrentlyCorrect: Bool {
        return elements.last != "+" && elements.last != "–" && elements.last != "x" && elements.last != "÷"
    }

//    var addPointDecimalIsCorrect: Bool {
//        for element in elements {
//            if element.rangeOfCharacter(from: validNumbers) != nil {
//                return element.contains(".")
//            } else {
//                return false
//            }
//        }
//        return false
//    }

    var canActiveResultEqual: Bool {
        print("true Equal")
        return elements.firstIndex(of: "=") != nil
    }

    var haveEnoughElementsWithPercent: Bool {
        return operation.firstIndex(of: "%") != nil
    }

    let formattedPercent: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter
    }()

    var addPointDecimalIsCorrect: Bool {
        guard let lastElement = elements.last else { return false }
        print("decimal")
        return !lastElement.contains(".")
    }

//    func decimalIsFirst () {
//        if addPointDecimalIsCorrect {
//            let elements: [String] = elements
//            elements.removeLast()
//            elements.last = "0."
//        }
//    }

        //MARK: - calculation

    func resultEqual() {
            // Create local copy of operations
        var operationsToReduce: [String] = elements
        print("voir \(operationsToReduce)")

        var resultToReduce: Float = 0.0

        if operationsToReduce.firstIndex(of: "%") != nil {
            resultToReduce = percentBeforeResult(operation: operationsToReduce)
        }

            // Iterate over operations while an operand still here
        while operationsToReduce.count >= 3 {

            indexPriorityOperands(operation: operationsToReduce)

            let left = Float(operationsToReduce[index-1])!
            let operators = operationsToReduce[index]
            let right = Float(operationsToReduce[index+1])!

            switch operators {
                case "x":
                    resultToReduce = left * right
                case "÷":
                    if right != 0 {
                        resultToReduce = left / right
                    } else {
                        operation = "Error: impossible divise by 0"
                        return
                    }
                case "+":
                    resultToReduce = left + right
                case "-":
                    resultToReduce = left - right
                default: fatalError("Unknown operator !")
            }
            if resultToReduce.isInfinite {
                operation = "to infinity and beyond"
                return
            }
            operationsToReduce.removeSubrange(index-1...index+1)
            operationsToReduce.insert("\(formattedResult(resultToReduce))", at: index-1)
            print("the formatted value = \(formattedResult(resultToReduce))")
        }

        result = resultToReduce

        operation.append(" = \(operationsToReduce.first!)")
        print("the calculation is: \(operation)")
        print("the result is: \(result)")
    }

        // recover the index of the priority operand
    func indexPriorityOperands(operation: [String]) {
        if operation.contains("x") && (elements.contains("+") || elements.contains("-")) {
            index = operation.firstIndex(of: "x")!
        }
        else if operation.contains("÷") && (elements.contains("+") || elements.contains("-")) {
            index = operation.firstIndex(of: "÷")!
        }
        else {
            index = 1
        }
    }

        // format decimal with 7 numbers
    func formattedResult(_ result: Float) -> String {
            // Use the method for substract if there is 0 after floating point and transform from Float to String
            // possible used formatted(FloatingPointFormatStyle(locale: Locale(identifier: "fr_FR"))) but is not works here
        
        var formattedValue = String(format: "%.7f", result)

        while formattedValue.last == "0" {
            formattedValue.removeLast()
        }

        if formattedValue.last == "." {
            formattedValue.removeLast()
        }

        return formattedValue
    }

    func percentBeforeResult(operation: [String]) -> Float {
        let operationWithPercent = operation
        var result: Float = 0.0

        if operationWithPercent.contains("%") {
            let index = operationWithPercent.firstIndex(of: "%") ?? 0

            var formatterPercent: String = operationWithPercent[index]
            print("percent before: \(formatterPercent) ")

            formatterPercent.removeLast()
            print("percent after: \(formatterPercent) ")

            let percent = Float(formatterPercent)!
            let number = Float(operationWithPercent[index-2])!

            if operationWithPercent.contains("+") {
                result = number + (number * percent / 100)
            }
            else if operationWithPercent.contains("-") {
                result = number - (number * percent / 100)
            }
            else {
                result = percent / 100
                print("percent result: \(result))")
            }
            print("percent result: \(result))")
        }
        return result
    }

}
