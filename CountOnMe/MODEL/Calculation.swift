//
//  CalculateWithOperator.swift
//  CountOnMe
//
//  Created by Gregory Deveaux on 19/06/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculation {

    var operation: String = "0"

    let validCharacters = CharacterSet(charactersIn: "0123456789-+x÷%.=")

    var elements: [String] {
        return operation.split(separator: " ").map { "\($0)" }
    }

    var result: Float = 0

    var haveEnoughElementsAndInOddNumber: Bool {
        return elements.count >= 3 && elements.count % 2 != 0
    }

    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "–" && elements.last != "x" && elements.last != "÷"
    }

    var canActiveResultEqual: Bool {
        print("true Equal")
        return elements.firstIndex(of: "=") != nil
    }

        // Error check computed variables
    var hasBeenCalculate: Bool {
        print("true result change")
        return canActiveResultEqual && haveEnoughElementsAndInOddNumber
    }

//    let numberWithPercent: FloatingPointFormatStyle.Percent! {
//        let number.Float!
//        return FloatingPointFormatStyle.Percent(from: number)
//    }

    

    func resultEqual() {
        print("array operation: \(operation)")
        print("array calc: \(elements)")

            // Create local copy of operations
        var operationsToReduce = elements
        var resultToReduce: Float = 0.0

            // Iterate over operations while an operand still here
        while operationsToReduce.count >= 3 {
            let left = Float(operationsToReduce[0])!
            let operators = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!

            if elements.contains("%") {
//                resultToReduce = numberWithPercent()
            }

            switch operators {
                case "+":
                    resultToReduce = left + right
                case "-":
                    resultToReduce = left - right
                case "x":
                    resultToReduce = left * right
                case "÷":
                    if right != 0 {
                        resultToReduce = left / right
                    } else {
                        operation = "Error"
                        return
                    }
                default: fatalError("Unknown operator !")
            }

                // Use the method for substract if there is 0 after floating point and transform from Float to String
            let resultFormatted = resultToReduce.formatted(FloatingPointFormatStyle())
            print(resultFormatted)

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(resultFormatted)", at: 0)
        }

        result = resultToReduce

        operation.append(" = \(operationsToReduce.first!)")
        print("array final: \(operation)")
        print(result)
    }

}

