//
//  UIView+Extensions.swift
//  CountOnMe
//
//  Created by Greg-Mini on 30/06/2022.
//  Copyright © 2022 Gregory Deveaux. All rights reserved.
//

import UIKit

extension UIView {
    func GreenHalo () {
        layer.shadowColor = CGColor(red: 68/255, green: 255/255, blue: 60/255, alpha: 1)
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 0.4
        layer.masksToBounds = false
    }
}
