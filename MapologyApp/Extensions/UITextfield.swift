//
//  UITextfield.swift
//  MapologyApp
//
//  Created by 34in on 14/03/17.
//  Copyright © 2017 Harsh. All rights reserved.
//

import UIKit


extension UITextField {
    
    func setLeftPaddingPoints(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
}
    
}

extension UIButton {
    
    func SetBordor()
    {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 0.5
        layer.masksToBounds = true
    }
}

extension UILabel {
    
    func SetBordor()
    {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 0.5
        layer.masksToBounds = true
    }
}


