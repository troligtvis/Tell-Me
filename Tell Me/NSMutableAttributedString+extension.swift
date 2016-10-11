//
//  NSMutableAttributedString+extension.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-11.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import UIKit


extension NSMutableAttributedString {
    func bold(text: String, size: CGFloat, weight: CGFloat) -> NSMutableAttributedString {
        let attrs: [String:AnyObject] = [NSFontAttributeName : UIFont.systemFont(ofSize: size, weight: weight)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes: attrs)
        
        self.append(boldString)
        return self
    }
    
    func normal(text: String) -> NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
}
