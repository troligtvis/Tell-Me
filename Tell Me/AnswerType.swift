//
//  AnswerType.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-11.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import Foundation

enum AnswerType {
    case yes
    case no
    case maybe
    
    init(withString string: String){
        switch string{
            case "yes": self = .yes
            case "no": self = .no
            default: self = .maybe
        }
    }
}
