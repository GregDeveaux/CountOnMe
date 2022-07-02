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

        // create the string of the operation
    var operation: String = "0"

        // we don't used other characters for the operation
    let validCharacters = CharacterSet(charactersIn: "0123456789-+x÷%.=")

    var state: State = .isOver

        // the operation is separate into several values due to space
    var elements: [String] {
        return operation.split(separator: " ").map { "\($0)" }
    }

    var result: Float = 0

        // verify than the operation contains what's needed
    var haveEnoughElementsAndInOddNumber: Bool {
        return elements.count >= 3 && elements.count % 2 != 0
    }

        // add an operator if there is none, percent or equal
    var operationIsCurrentlyCorrect: Bool {
        return elements.last != "+" && elements.last != "–" && elements.last != "x" && elements.last != "÷"
    }

    var canActiveResultEqual: Bool {
        print("true Equal")
        return elements.firstIndex(of: "=") != nil
    }

//    var numberWithPercent: Float {
//        let number.Float!
//        return FloatingPointFormatStyle.Percent(from: number)
//    }

    

    func resultEqual() {
        print("array operation: \(operation)")
        print("array calc: \(elements)")

            // Create local copy of operations
        var operationsToReduce: [String] = elements
        print("voir \(operationsToReduce)")

        var resultToReduce: Float = 0.0

            // Iterate over operations while an operand still here
        while operationsToReduce.count >= 3 {

            var index = 0

            if operationsToReduce.contains("x") && (elements.contains("+") || elements.contains("-")) {
                index = operationsToReduce.firstIndex(of: "x")!
            }
            else if operationsToReduce.contains("÷") && (elements.contains("+") || elements.contains("-")) {
                index = operationsToReduce.firstIndex(of: "÷")!
            }
            else {
                index = 1
            }

            let left = Float(operationsToReduce[index-1])!
            let operators = operationsToReduce[index]
            let right = Float(operationsToReduce[index+1])!

            if elements.contains("%") {
//                resultToReduce = numberWithPercent()
            }

            switch operators {
                case "x":
                    resultToReduce = left * right
                case "÷":
                    if right != 0 {
                        resultToReduce = left / right
                    } else {
                        operation = "Error"
                        return
                    }
                case "+":
                    resultToReduce = left + right
                case "-":
                    resultToReduce = left - right
                default: fatalError("Unknown operator !")
            }

                // Use the method for substract if there is 0 after floating point and transform from Float to String
//            let resultFormatted = resultToReduce.formatted(FloatingPointFormatStyle())
//            print(resultFormatted)
            operationsToReduce.removeSubrange(index-1...index+1)
            operationsToReduce.insert("\(resultToReduce)", at: index-1)
            print("result avant ajout: \(operationsToReduce)")
            index = 0
        }

        result = resultToReduce

        operation.append(" = \(operationsToReduce.first!)")
        print("array final: \(operation)")
        print(result)
    }

}

