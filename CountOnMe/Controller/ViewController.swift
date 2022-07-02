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

    @IBOutlet weak var screen: UIView!

    var calculation = Calculation()


       // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        let field = UITextField(frame: .zero)
            field.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        designButtons()
        numberView.designFont()
        screen.GreenHalo()

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
        if calculation.state == .isOver {
            numberView.text = ""
        }
    }

        // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        initNilStartCalculation()
        calculation.state = .isProgress

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
        calculation.state = .isOver
        print("AC")
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {

        guard calculation.haveEnoughElementsAndInOddNumber else {
            return showAlertWrongTouch(title: "Attention!", message: "Il manque un nombre !")
        }

        guard !calculation.canActiveResultEqual && calculation.operationIsCurrentlyCorrect else {
            return showAlertWrongTouch(title: "Attention!", message: "Entrez une expression correcte !")
        }

        numberView.resignFirstResponder()

        calculation.resultEqual()
        numberView.text = calculation.operation
        calculation.state = .isOver
    }

    private func showAlertWrongTouch(title: String, message: String) {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
    }

    private func mathOperator(tapped operand: String) {
        print (">>>\(operand)")
        if calculation.operationIsCurrentlyCorrect {
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

