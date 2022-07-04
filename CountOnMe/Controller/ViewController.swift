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

        numberView.text = String(numberView.text.prefix(50))

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
    }

        //MARK: - Buttons
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

    @IBAction func tappedPointButton(_ sender: UIButton) {
        if calculation.addPointDecimalIsCorrect {
            numberView.text.append(".")
            calculation.operation = numberView.text
        } else {
            showAlertWrongTouch(title: "Attention!", message: "Un point décimal est déja mis !")
        }
    }

    @IBAction func tappedPercentButton(_ sender: UIButton) {
        mathOperator(tapped: "%")
        let converter = calculation.formattedPercent.number(from: calculation.operation)!
        calculation.operation = String(describing: converter)
        print(numberView.text as Any)
        print(calculation.elements)
        print(converter as Any)
        calculation.resultEqual()
        calculation.state = .isOver
    }

        // remove operation
    @IBAction func tappedResetButton(_ sender: UIButton) {
        numberView.text = "0"
        calculation.state = .isOver
        print("AC")
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {

        guard calculation.haveEnoughElementsAndInOddNumber || calculation.haveEnoughElementsWithPercent else {
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

//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//            // get the current text, or use an empty string if that failed
//            numberView.text = textView.text ?? ""
//
//            // attempt to read the range they are trying to change, or exit if we can't
//            guard let stringRange = Range(range, in: numberView.text) else { return false }
//
//            // add their new text to the existing text
//            let updatedText = numberView.text.replacingCharacters(in: stringRange, with: text)
//
//            // make sure the result is under 16 characters
//            return updatedText.count <= 16
//    }


}

