//
//  CardRelation.swift
//  KPTer
//
//  Created by Kaori Sawamura on 2/28/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import Foundation
import RealmSwift


class CardRelation: Object {
    
    dynamic var id = NSUUID().UUIDString
    dynamic var from_id = ""
    dynamic var to_id = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
