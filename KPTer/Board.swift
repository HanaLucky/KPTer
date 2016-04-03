//
//  Board.swift
//  KPTer
//
//  Created by Kaori Sawamura on 2/28/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import Foundation
import RealmSwift


class Board: Object {
    
    dynamic var id = NSUUID().UUIDString
    dynamic var board_title = ""
    var cards = List<Card>()
    dynamic var created_at = NSDate()
    dynamic var updated_at = NSDate()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
