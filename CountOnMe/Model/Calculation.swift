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

    var operation: String = "0"

    var state: State = .isOver

        // the operation is separate into several values due to space
    var elements: [String] {
        return operation.split(separator: " ").map{ "\($0)" }
    }

    var result: Float = 0

    var index = 0


        //MARK: - verify actions
        // set of computed proporties for the verifications

    var haveEnoughElementsAndInOddNumber: Bool {
        return elements.count >= 3 && elements.count % 2 != 0
    }

        // add an operator if there is none
    var operationIsCurrentlyCorrect: Bool {
        return elements.last != "+" && elements.last != "–" && elements.last != "x" && elements.last != "÷" && elements.last != "."
    }

    var canActiveResultEqual: Bool {
        print("true Equal")
        return elements.firstIndex(of: "=") != nil
    }

    var haveFindElementWithPercent: Bool {
        return operation.firstIndex(of: "%") != nil
    }

    var addPointDecimalIsCorrect: Bool {
        guard let lastElement = elements.last else { return false }
        print("decimal")
        return !lastElement.contains(".")
    }



        //MARK: - calculation classic operations

    func resultEqual() {
            // Create local copy of operations
        var operationsToReduce: [String] = elements
        print("voir \(operationsToReduce)")

        var resultToReduce: Float = 0.0

        if haveFindElementWithPercent {
            resultToReduce = percentBeforeResult(operation: operationsToReduce)
            operation.append(" = \(resultToReduce)")
            result = resultToReduce
            return
        } else {
                // Iterate over operations while an operand still here
            while operationsToReduce.count >= 3 {

                indexPriorityOperands(operation: operationsToReduce)

                guard let left = Float(operationsToReduce[index-1]) else { return }
                let operators = operationsToReduce[index]
                guard let right = Float(operationsToReduce[index+1]) else { return }

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
        }

        result = resultToReduce

        operation.append(" = \(operationsToReduce.first!)")
        print("the calculation is: \(operation)")
        print("the result is: \(result)")
    }

        // recover the index of the priority operand
    private func indexPriorityOperands(operation: [String]) {
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


        //MARK: - formatted decimal
        // format decimal with 7 numbers

    private func formattedResult(_ result: Float) -> String {
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


    
        //MARK: - calculation percent operations
        // Calculate the different results according to the operand or the first element in the operation

    func percentBeforeResult(operation: [String]) -> Float {
        var result: Float = 0.0

        if let index = operation.firstIndex(where: { $0.contains("%") }) {
            var formatterPercent: String = operation[index]
            print("percent before: \(formatterPercent) and index = \(index)")

            formatterPercent.removeLast()
            print("percent after: \(formatterPercent) ")

            if let percent = Float(formatterPercent) {
                if index == 0 {
                    result = percent / 100
                }
                else {
                    if let number = Float(operation[index-2]) {
                        result = percentOperationWithOperand(operation: operation, number: number, percent: percent)
                    }
                }
            }
            print("percent result: \(result))")
        }
        return result
    }

    func percentOperationWithOperand(operation: [String], number: Float, percent: Float) -> Float {
        switch operation {
            case _ where operation.contains("x"):
                result = number * (percent / 100)

            case _ where operation.contains("÷"):
                result = number / (percent / 100)

            case _ where operation.contains("+"):
                result = number + (number * percent / 100)

            case _ where operation.contains("-"):
                result = number - (number * percent / 100)

            default: fatalError("Unknown operator !")
        }
        return result
    }

}
