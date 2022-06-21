//
//  CalculateWithOperator.swift
//  CountOnMe
//
//  Created by Gregory Deveaux on 19/06/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculation {

    var calculationResult: Float = 0

    var calculationTapped: String = "0"

    var calculationElements: [String] {
        return calculationTapped.split(separator: " ").map { "\($0)" }
    }

        // Error check computed variables
    var expressionIsCorrect: Bool {
        return calculationElements.last != "+" && calculationElements.last != "–"
    }

    var expressionHaveEnoughElements: Bool {
        return calculationElements.count >= 3
    }

    var canAddOperator: Bool {
        return calculationElements.last != "+" && calculationElements.last != "–"
    }

    var expressionHaveResult: Bool {
        return calculationTapped.firstIndex(of: "=") != nil
    }


    func resultEqual() {
            // Create local copy of operations
        var operationsToReduce = calculationElements

            // Iterate over operations while an operand still here
        while calculationElements.count > 1 {
            let left = Float(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!

            switch operand {
                case "+":
                    calculationResult = left + right
                case "-":
                    calculationResult = left - right
                case "x":
                    calculationResult = left * right
                case "÷":
                    calculationResult = left / right
                case "AC":
                    calculationResult = 0
                default: fatalError("Unknown operator !")
            }

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(calculationResult)", at: 0)
        }

        calculationTapped.append(" = \(operationsToReduce.first!)")
    }




}
