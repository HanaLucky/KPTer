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
            card.type = editCard.type
        }
    }
    
    class func delete(card: Card){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(card)
        }
    }
    
    class func addCardRelation(fromId: String, toId: String) {
        let cardRelation = CardRelation()
        cardRelation.from_id = fromId
        cardRelation.to_id = toId
        let realm = try! Realm()
        try! realm.write {
            realm.add(cardRelation)
        }
    }
    
    class func deleteCardRelation(tryCard: Card) {
        let realm = try! Realm()
        let cardRelation = realm.objects(CardRelation).filter("to_id = '\(tryCard.id)'")
        try! realm.write {
            realm.delete(cardRelation)
        }
    }
    
    class func changeStatus(card: Card, status: Card.CardStatus){
        let realm = try! Realm()
        try! realm.write {
            card.status = status.rawValue
        }
    }
}