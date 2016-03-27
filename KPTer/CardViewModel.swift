//
//  CardViewModel.swift
//  KPTer
//
//  Created by Kaori Sawamura on 3/21/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import Foundation
import RealmSwift

class CardViewModel {

    class func create(title: String, detail: String) -> Card? {
        let card = Card()
        card.card_title = title
        let realm = try! Realm()
        try! realm.write {
            realm.add(card)
        }
        return card
    }
    
    class func edit(card: Card, title: String, detail: String){
        let realm = try! Realm()
        try! realm.write {
            card.card_title = title
        }
    }
    
    class func delete(card: Card){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(card)
        }
    }
}