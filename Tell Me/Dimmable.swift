//
//  Dimmable.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-11.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import UIKit

enum Direction {
    case up
    case down
}

protocol Dimmable { }

extension Dimmable where Self: UIViewController{
    func dim(direction: Direction, color: UIColor = UIColor.black, alpha: CGFloat = 0.0, speed: Double = 0.0){
        switch direction{
        case .up:
            let dimView = UIView(frame: view.frame)
            dimView.backgroundColor = color
            dimView.alpha = 0.0
            view.addSubview(dimView)
            
            dimView.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[dimView]|", options: [], metrics: nil, views: ["dimView": dimView]))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimView]|", options: [], metrics: nil, views: ["dimView": dimView]))
            
            UIView.animate(withDuration: speed, animations: {
                dimView.alpha = alpha
            })
        case .down:
            UIView.animate(withDuration: speed, animations: { () -> Void in
                self.view.subviews.last?.alpha = alpha
                }, completion: { (complete) -> Void in
                    self.view.subviews.last?.removeFromSuperview()
            })
        }
    }
}
