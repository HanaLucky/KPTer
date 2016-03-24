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
    
    dynamic var board_id = 0
    dynamic var board_title = ""
    var cards = List<Card>()
    
//    override static func primaryKey() -> String? {
//        return "board_id"
//    }
}
