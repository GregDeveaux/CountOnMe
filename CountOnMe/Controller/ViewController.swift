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

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!

    var calculation = Calculation()


       // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        designButtons()

        textView.delegate = self

//        calculation.operationDelegate = self
//        didRecieveOperationUpdate(textView.text)
//        calculation.requestOperation()

    }

    // Design all buttons
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

        textView.resignFirstResponder()

        guard let numberText = sender.title(for: .normal) else { return }

        textView.text.append(numberText)
        calculation.operation = textView.text

        print("tapped: \(textView.text!)")
        print(calculation.elements)

//        if calculation.hasBeenCalculate {
//            textView.text = "0"
//        }
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
//        if (textView.text.last != nil) == calculation.canAddOperator {
//            let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
//            if numbers.description.contains(operation.last!) {
//                textView.text.append(calculation.numberWithPercent(number: calculation.elements.last))
//            }
//        } else {
//            showAlertWrongTouch(title: "Attention!", message: "Il manque un nombre pour utiliser le % !")
//        }
    }




    private func showAlertWrongTouch(title: String, message: String) {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
    }

    private func mathOperator(tapped operand: String) {
        print (calculation.canAddOperator)
        if calculation.canAddOperator {
            textView.text.append(operand)
            calculation.operation = textView.text
        } else {
            showAlertWrongTouch(title: "Attention!", message: "Un operateur est déja mis !")
        }
    }

        // remove operation
    @IBAction func tappedResetButton(_ sender: UIButton) {
        print("AC")
        textViewDidEndEditing(textView)
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {

        guard calculation.haveEnoughElementsAndInOddNumber else {
            return showAlertWrongTouch(title: "Attention!", message: "Il manque un nombre !")
        }

        guard !calculation.canActiveResultEqual else {
            return showAlertWrongTouch(title: "Attention!", message: "Entrez une expression correcte !")
        }


        calculation.resultEqual()
        textView.text = calculation.operation
    }

}


extension ViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        print ("my operation begin editing")
    }

    internal func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = "5"
    }

    internal func textViewDidChange(_ textView: UITextView) {
        print ("my operation is : \(textView.text ?? "5")")
    }

}

//extension ViewController: OperationModelDelegate {
//    func didRecieveOperationUpdate(_ operation: String) {
//        print(operation)
//    }
//}

