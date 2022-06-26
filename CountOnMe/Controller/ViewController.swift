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

//protocol OperationModelDelegate {
//    func didRecieveOperationUpdate(_ operation: String)
//}

class ViewController: UIViewController {

    var calculation = Calculation()

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!

    var operation: String = "25.25 ÷ 25.37" {
        didSet {
            operation = textView.text
            print("old calcul: \(oldValue) ")
            print("new calcul: \(operation) ")
        }
    }


    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = "0"
        designButtons()

        calculation.operation = operation
        print("o++++++++++\(operation)")

//        calculation.operationDelegate = self
//        didRecieveOperationUpdate(textView.text)
//        calculation.requestOperation()

    }

    // Design buttons
    func designButtons() {
        let allButtons = numberButtons + operatorButtons

        allButtons.forEach { $0.designButton() }
    }

    func initNilStartCalculation() {
        if textView.text == "0" {
            textView.text = ""
        }
    }

        // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        
        guard calculation.haveEnoughElements else { return }
        guard let numberText = sender.title(for: .normal) else { return }

        initNilStartCalculation()

        if calculation.hasBeenCalculate {
            textView.text = "0"
        }
        textView.text.append(numberText)
        print("tapped: \(textView.text!)")

    }

    private func showAlertWrongTouch(title: String, message: String) {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        mathOperator(tapped: " + ")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        mathOperator(tapped: " - ")
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        mathOperator(tapped: " x ")
    }

    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        mathOperator(tapped: " ÷ ")
    }

    @IBAction func tappedPercentButton(_ sender: UIButton) {
        if (textView.text.last != nil) == calculation.canAddOperator {
            var numberString = operation.last
            var numberFloat = Float(numberString)
            textView.text.append(calculation.numberWithPercent(number: numberFloat))
        } else {
            showAlertWrongTouch(title: "Attention!", message: "Il manque un nombre pour utiliser le % !")
        }
    }

    private func mathOperator(tapped operand: String) {
        print (calculation.canAddOperator)
        if calculation.canAddOperator {
            textView.text.append(operand)
        } else {
            showAlertWrongTouch(title: "Attention!", message: "Un operateur est déja mis !")
        }
    }

        // remove operation
    @IBAction func tappedResetButton(_ sender: UIButton) {
        print("AC")
        textView.text = "0"
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculation.haveEnoughElements else {
            return showAlertWrongTouch(title: "Attention!", message: "Il manque un nombre !")
        }

        guard !calculation.canActiveResultEqual else {
            return showAlertWrongTouch(title: "Attention!", message: "Entrez une expression correcte !")
        }

        calculation.resultEqual()
        textView.text = calculation.operation
    }

}

//extension ViewController: OperationModelDelegate {
//    func didRecieveOperationUpdate(_ operation: String) {
//        print(operation)
//    }
//}

