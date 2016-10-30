//
//  UIView+extension.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-16.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import UIKit

public extension UIView {
    func shake(count : Float? = nil, for duration: TimeInterval? = nil, withTanslation translation: Float? = nil) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        animation.repeatCount = count ?? 2
        animation.duration = (duration ?? 0.5)/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation ?? -5
        layer.add(animation, forKey: "shake")
    }
    
    func shadowfy(){
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.25
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.masksToBounds = false
    }
}
