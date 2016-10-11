//
//  Answer.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-11.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import Foundation
import SwiftyJSON

final class Answer: ResponseJSONObjectSerializable{
    
    let value: String?
    let url: String?
    let forced: Bool?
    
    init?(json: JSON) {
        self.value = json["answer"].string
        self.forced = json["forced"].bool
        self.url = json["image"].string
    }
    
    func getValue() -> AnswerType {
        guard let value = value else {
            return AnswerType.maybe
        }
        
        return AnswerType(withString: value)
    }
}
