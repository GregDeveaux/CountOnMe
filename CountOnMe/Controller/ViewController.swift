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

    @IBOutlet weak var numberView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!

    @IBOutlet weak var Screen: UIView!

    var calculation = Calculation()


       // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        designButtons()

        numberView.font = UIFont.init(name: "Seven Segment", size: 70)
        numberView.layer.shadowColor = CGColor(red: 68/255, green: 255/255, blue: 60/255, alpha: 1)
        numberView.layer.shadowOffset = CGSize(width: 3, height: 2)
        numberView.layer.shadowOpacity = 0.9
        numberView.layer.masksToBounds = false

        Screen.layer.shadowColor = CGColor(red: 68/255, green: 255/255, blue: 60/255, alpha: 1)
        Screen.layer.shadowOffset = CGSize(width: 2, height: 2)
        Screen.layer.shadowOpacity = 0.4
        Screen.layer.masksToBounds = false
        

        numberView.delegate = self

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
        if numberView.text == "0" {
            numberView.text = ""
        }
    }

        // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        initNilStartCalculation()

        guard let numberText = sender.title(for: .normal) else { return }

        numberView.resignFirstResponder()

        numberView.text.append(numberText)
        calculation.operation = numberView.text

        print("tapped: \(numberView.text!)")
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
//        if (numberView.text.last != nil) == calculation.canAddOperator {
//            let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
//            if numbers.description.contains(calculation.operation.last!) {
//                numberView.text.append(calculation.numberWithPercent(number: Float(calculation.elements.last)))
//            }
//        } else {
//            showAlertWrongTouch(title: "Attention!", message: "Il manque un nombre pour utiliser le % !")
//        }
    }

        // remove operation
    @IBAction func tappedResetButton(_ sender: UIButton) {
        numberView.text = "0"
        print("AC")
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {

        guard calculation.haveEnoughElementsAndInOddNumber else {
            return showAlertWrongTouch(title: "Attention!", message: "Il manque un nombre !")
        }

        guard !calculation.canActiveResultEqual else {
            return showAlertWrongTouch(title: "Attention!", message: "Entrez une expression correcte !")
        }

        numberView.resignFirstResponder()

        calculation.resultEqual()
        numberView.text = calculation.operation
    }

    private func showAlertWrongTouch(title: String, message: String) {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
    }

    private func mathOperator(tapped operand: String) {
        print (">>>\(operand)")
        if calculation.canAddOperator {
            numberView.text.append(operand)
            calculation.operation = numberView.text
        } else {
            showAlertWrongTouch(title: "Attention!", message: "Un operateur est déja mis !")
        }
    }

}


extension ViewController: UITextViewDelegate {

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        numberView.text = "18"
        print ("my operation begin editing")
        return true
    }


    func textViewDidBeginEditing(_ textView: UITextView) {
        numberView.text = "23"
        print ("my operation begin editing")
    }

    func textViewDidEndEditing(_ textView: UITextView) {
    }



}

