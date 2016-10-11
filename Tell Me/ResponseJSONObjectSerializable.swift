//
//  ResponseJSONObjectSerializable.swift
//  Tell Me
//
//  Created by Kj Drougge on 2016-10-11.
//  Copyright © 2016 Code Fork. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol ResponseJSONObjectSerializable {
    init?(json: JSON)
}
