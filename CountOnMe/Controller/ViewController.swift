//
//  ViewController.swift
//  CountOnMe
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//
//  Revised by Gregory Deveaux on 19/06/2022.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!

    let calculation = Calculation(operation: textView.text)



//    var elements: [String] {
//        return textView.text.split(separator: " ").map { "\($0)" }
//    }
//    
//    // Error check computed variables
//    var expressionIsCorrect: Bool {
//        return elements.last != "+" && elements.last != "–"
//    }
//    
//    var expressionHaveEnoughElement: Bool {
//        return elements.count >= 3
//    }
//    
//    var canAddOperator: Bool {
//        return elements.last != "+" && elements.last != "–"
//    }
//    
//    var expressionHaveResult: Bool {
//        return textView.text.firstIndex(of: "=") != nil
//    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        designButtons()

    }

    // Design buttons
    func designButtons() {
        let allButtons = numberButtons + operatorButtons

        allButtons.forEach { $0.designButton() }
    }

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if calculation.expressionHaveResult {
            textView.text = ""
            calculation.calculationTapped = textView.text
        }
        print(numberText)
        textView.text.append(numberText)
        print(calculationTapped)
    }

    func showAlertWrongTouch(title: String, message: String) {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calculation.canAddOperator {
            textView.text.append(" + ")
        } else {
            showAlertWrongTouch(title: "Zéro!", message: "Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calculation.canAddOperator {
            textView.text.append(" - ")
        } else {
            showAlertWrongTouch(title: "Zéro!", message: "Un operateur est déja mis !")
        }
    }
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if calculation.canAddOperator {
            textView.text.append(" x ")
        } else {
            showAlertWrongTouch(title: "Zéro!", message: "Un operateur est déja mis !")
        }
    }

    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if calculation.canAddOperator {
            textView.text.append(" ÷ ")
        } else {
            showAlertWrongTouch(title: "Zéro!", message: "Un operateur est déja mis !")
        }
    }

    @IBAction func tappedResetButton(_ sender: UIButton) {
        if calculation.canAddOperator {
            textView.text.append(" AC ")
        } else {
            showAlertWrongTouch(title: "Zéro!", message: "Un operateur est déja mis !")
        }
    }


    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculation.expressionIsCorrect else {
            return showAlertWrongTouch(title: "Zéro!", message: "Entrez une expression correcte !")
        }
        
        guard calculation.expressionHaveEnoughElements else {
            return showAlertWrongTouch(title: "Zéro!", message: "Démarrez un nouveau calcul !")
        }
        
//        // Create local copy of operations
//        var operationsToReduce = elements
//        
//        // Iterate over operations while an operand still here
//        while operationsToReduce.count > 1 {
//            let left = Float(operationsToReduce[0])!
//            let operand = operationsToReduce[1]
//            let right = Float(operationsToReduce[2])!
//            
//            let result: Float
//
//            switch operand {
//                case "+":
//                    result = left + right
//                case "-":
//                    result = left - right
//                case "x":
//                    result = left * right
//                case "÷":
//                    result = left / right
//                case "AC":
//                    result = 0
//                default: fatalError("Unknown operator !")
//            }
//            
//            operationsToReduce = Array(operationsToReduce.dropFirst(3))
//            operationsToReduce.insert("\(result)", at: 0)
//        }
//        
//        textView.text.append(" = \(operationsToReduce.first!)")
    }

}

