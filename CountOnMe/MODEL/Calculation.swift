//
//  CalculateWithOperator.swift
//  CountOnMe
//
//  Created by Gregory Deveaux on 19/06/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculation {

    var result: Float = 0

    var operation: [String] = []

    var elements: [String] {
        return operation.split(separator: " ").map { "\($0)" }
    }

    var expressionHaveEnoughElements: Bool {
        return elements.count >= 3
    }

        // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "–" && elements.last != "x" && elements.last != "÷"
    }

    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "–" && elements.last != "x" && elements.last != "÷"
    }

    var expressionHaveResult: Bool {
        return operation.firstIndex(of: "=") != nil
    }


    func resultEqual() {
            // Create local copy of operations
        var operationsToReduce = elements

            // Iterate over operations while an operand still here
        while calculationElements.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!

            switch operand {
                case "+":
                    result = left + right
                case "-":
                    result = left - right
                case "x":
                    result = left * right
                case "÷":
                    result = left / right
                case "AC":
                    result = ""
                    operation.removeAll()
                default: fatalError("Unknown operator !")
            }

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }

        operation.append(" = \(operationsToReduce.first!)")
    }




}
