//
//  Card.swift
//  KPTer
//
//  Created by Kaori Sawamura on 2/28/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import Foundation
import RealmSwift

class Card: Object {
    
    dynamic var id = NSUUID().UUIDString
    dynamic var card_title = ""
    dynamic var detail = ""
    dynamic var type = ""
    dynamic var status = ""
    dynamic var order = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
