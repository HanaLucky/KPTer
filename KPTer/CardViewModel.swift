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

    class func create(title: String, detail: String, type: Card.CardType) -> Card? {
        let card = Card()
        card.card_title = title
        card.detail = detail
        card.status = Card.CardStatus.Open.rawValue
        card.type = type.rawValue
        let realm = try! Realm()
        try! realm.write {
            realm.add(card)
        }
        return card
    }
    
    class func edit(card: Card, editCard: Card){
        let realm = try! Realm()
        try! realm.write {
            card.card_title = editCard.card_title
            card.detail = editCard.detail
        }
    }
    
    class func delete(card: Card){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(card)
        }
    }
    
    class func changeStatus(card: Card, status: Card.CardStatus){
        let realm = try! Realm()
        try! realm.write {
            card.status = status.rawValue
        }
    }
}