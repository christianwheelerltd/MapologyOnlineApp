//
//  UIColor.swift
//  NewList
//
//  Created by 34in on 22/11/16.
//  Copyright © 2016 thirtyfourInteractive. All rights reserved.
//

import UIKit

extension UIColor {

//    func color () -> UIColor
//    {
//   return color_Cell_bg
//    }
//    
}


extension UINavigationController {
    
    func NavigationBar ()
    {
    

    }
    
}


extension UIView
{
    func bottomBorder(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:self.frame.size.height - width, width:self.frame.size.width, height:width)
        self.layer.addSublayer(border)
    }
}

extension UIButton {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0,y: 0, width:self.frame.size.width, height:width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width,y: 0, width:width, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:self.frame.size.height - width, width:self.frame.size.width, height:width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y:0, width:width, height:self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    
    
}




extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: thickness, height: frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect.init(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
}


//MARK: Global Function

func attributedString(from string: String, nonBoldRange: NSRange?) -> NSAttributedString {
    let fontSize =  CGFloat(20) //UIFont.systemFontSize
    let attrs = [
        NSFontAttributeName: UIFont.boldSystemFont(ofSize: fontSize),
        NSForegroundColorAttributeName: UIColor.black
    ]
    let nonBoldAttribute = [
        NSFontAttributeName: UIFont.systemFont(ofSize: fontSize),
        ]
    let attrStr = NSMutableAttributedString(string: string, attributes: attrs)
    if let range = nonBoldRange {
        attrStr.setAttributes(nonBoldAttribute, range: range)
    }
    return attrStr
}


    
    func NavigationTitle(size:UIView) -> UILabel
{
    let targetString = "Mapology"
    let range = NSMakeRange(0, 3)
    
    let label = UILabel(frame: CGRect(x:0, y:0, width:size.frame.size.width, height:44))
    
    label.textAlignment = .center
    label.attributedText = attributedString(from: targetString, nonBoldRange: range)
    
    label.textColor = UIColor.white
    
    return label

}


    
