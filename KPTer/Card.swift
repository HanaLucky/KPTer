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
    
    dynamic var card_id = 0
    dynamic var card_title = ""
    dynamic var type = ""
    dynamic var detail = ""
    dynamic var order = 0

}
