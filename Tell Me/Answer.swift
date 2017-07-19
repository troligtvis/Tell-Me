//
//  Answer.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-11.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import Foundation

final class Answer: ResponseJSONObjectSerializable{
    
    let value: String?
    let url: String?
    let forced: Bool?
    
    var isFavorite: Bool = false
    var question: String = ""
    
    init(value: String?, url: String?){
        self.value = value
        self.url = url
        self.forced = false
    }
    
    init?(fav: FavoriteAnswer){
        self.value = fav.value
        self.url = fav.imageUrl
        self.question = fav.question
        self.forced = false
    }
    
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
