//
//  CalulatorButtons.swift
//  CountOnMe
//
//  Created by Gregory Deveaux on 20/06/2022.
//  Copyright © 2022 Gregory Deveaux. All rights reserved.
//

import UIKit

extension UIButton {

    func designButton() {
        layer.masksToBounds = true
        layer.cornerRadius = 5

        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOffset = CGSize(width: 5,
                                    height: 5)
        layer.masksToBounds = false
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 1.1

        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.borderWidth = 1

        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 40, y: 40),
                                      radius: 35,
                                      startAngle: 0,
                                      endAngle: 360,
                                      clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.frame = bounds
        layer.addSublayer(shapeLayer)

        let effectBlur = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
//        layer.addSublayer(effectBlur)
    }

}
