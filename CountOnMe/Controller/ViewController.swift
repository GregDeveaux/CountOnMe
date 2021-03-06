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

        // MARK: - IBOutlets
    @IBOutlet weak var numberView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!

    @IBOutlet weak var screen: UIView!

    var calculation = Calculation()
    

        // MARK: - ViewDidLoad
        // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        designButtons()
        numberView.designFont()
        screen.GreenHalo()
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


        //MARK: - Actions buttons

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        if numberView.text != "0." {
            initNilStartCalculation()
        }
        
        calculation.state = .isProgress

        guard let numberText = sender.title(for: .normal) else { return }

        numberView.text.append(numberText)
        calculation.operation = numberView.text

        print("tapped: \(numberView.text!)")
        print(calculation.elements)
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

    @IBAction func tappedPointButton(_ sender: UIButton) {
        if calculation.addPointDecimalIsCorrect {
            numberView.text.append(".")
            calculation.operation = numberView.text
        } else {
            showAlertWrongTouch(title: "Attention!", message: "Un point décimal est déja mis !")
        }
    }

    @IBAction func tappedPercentButton(_ sender: UIButton) {
        if numberView.text.last != "%" && calculation.operationIsCurrentlyCorrect {
            mathOperator(tapped: "%")
            calculation.resultEqual()
            numberView.text = calculation.operation
            calculation.state = .isOver
        }
    }

        // reset operation
    @IBAction func tappedResetButton(_ sender: UIButton) {
        numberView.text = "0"
        calculation.state = .isOver
        print("AC")
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {

        guard calculation.haveEnoughElementsAndInOddNumber || calculation.haveFindElementWithPercent else {
            return showAlertWrongTouch(title: "Attention!", message: "Il manque un nombre !")
        }

        guard !calculation.canActiveResultEqual && calculation.operationIsCurrentlyCorrect else {
            return showAlertWrongTouch(title: "Attention!", message: "Entrez une expression correcte !")
        }

        calculation.resultEqual()
        numberView.text = calculation.operation
        calculation.state = .isOver
    }

    private func mathOperator(tapped operand: String) {
        print (">>>\(operand)")
        if calculation.operationIsCurrentlyCorrect && calculation.state != .isOver {
            numberView.text.append(operand)
            print (">>>\(String(describing: numberView.text))")
            calculation.operation = numberView.text
        }
        else if calculation.state == .isOver {
            calculation.state = .isProgress
            numberView.text = String(calculation.resultIsFormat)
            numberView.text.append(operand)
        }
        else {
            showAlertWrongTouch(title: "Attention!", message: "Un operateur est déja mis !")
        }
    }

        //MARK: - PopIn Alert

    private func showAlertWrongTouch(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }


}

