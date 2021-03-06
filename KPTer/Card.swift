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
    dynamic var created_at = NSDate()
    dynamic var updated_at = NSDate()
    
    enum CardType: String {
        case Keep = "Keep"
        case Problem = "Problem"
        case Try = "Try"
    }
    
    enum CardStatus: String {
        case Open = "Open"
        case Done = "Done"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func isKeep() -> Bool{
        return self.type == CardType.Keep.rawValue
    }
    
    func isProblem() -> Bool{
        return self.type == CardType.Problem.rawValue
    }
    
    func isTry() -> Bool{
        return self.type == CardType.Try.rawValue
    }
}
