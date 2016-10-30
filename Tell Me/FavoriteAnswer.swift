//
//  FavoriteAnswer.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-29.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteAnswer: Object {
    dynamic var answerId = NSUUID().uuidString
    dynamic var cacheKey: String = ""
    
    dynamic var imageUrl: String = ""
    dynamic var value: String = ""
    dynamic var question: String = ""
    
    override class func primaryKey() -> String? {
        return "answerId"
    }
}
