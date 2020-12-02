//
//  String+Extension.swift
//  CurrencyConverter
//
//  Created by Ashish on 01/12/20.
//  Copyright © 2020 MelpApp. All rights reserved.
//

import UIKit

extension UITextField {
    
    /// Just to ensure the right and left padding for textfield
    func paddingRL(_ padding: CGFloat) {
        self.leftViewMode  = .always
        self.leftView      = UIView(frame: .init(x: 0.0, y: 0.0, width: padding, height: padding))
        self.rightViewMode = .always
        self.rightView     = UIView(frame: .init(x: 0.0, y: 0.0, width: padding, height: padding))
    }
    
    /// just to diable the view of keyboard
    func inputView(_ view: UIView? = UIView(frame: CGRect.zero)) {
        self.inputView = view
    }
    
    /// uitextfield layer addition
    func layering(_ corner: CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = corner
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1.0
    }
    
}
