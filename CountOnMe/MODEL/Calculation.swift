//
//  CalculateWithOperator.swift
//  CountOnMe
//
//  Created by Gregory Deveaux on 19/06/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculation {

//    var operationDelegate: OperationModelDelegate?

    var operation: String = ""

    var elements: [String] {
        return operation.split(separator: " ").map { "\($0)" }
    }

    var result: Float = 0

    var haveEnoughElements: Bool {
        return elements.count >= 3 && !(elements.count % 2 == 0)
    }

    var canAddOperator: Bool {
        print("if \(String(describing: operation.last))")
        return elements.last != "+" && elements.last != "–" && elements.last != "x" && elements.last != "÷"
    }

    var canActiveResultEqual: Bool {
        print("true Equal")
        return operation.firstIndex(of: "=") != nil
    }

        // Error check computed variables
    var hasBeenCalculate: Bool {
        print("true result change")
        return canActiveResultEqual && haveEnoughElements
    }

//    func requestOperation() {
//        operation = "request operation"
//        operationDelegate?.didRecieveOperationUpdate(operation)
//        print(operation)
//    }

    func resultEqual() {
        print("array operation: \(operation)")
        print("array calc: \(elements)")

            // Create local copy of operations
        var operationsToReduce = elements
        var resultToReduce: Float = 0

            // Iterate over operations while an operand still here
        while operationsToReduce.count >= 3 {
            let left = Float(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!

            switch operand {
                case "+":
                    resultToReduce = left + right
                case "-":
                    resultToReduce = left - right
                case "x":
                    resultToReduce = left * right
                case "÷":
                    resultToReduce = left / right
                default: fatalError("Unknown operator !")
            }
            print(resultToReduce)

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(resultToReduce)", at: 0)
        }

        result = resultToReduce

        operation.append(" = \(operationsToReduce.first!)")
        print("array final: \(operation)")
        print(result)
    }

}

