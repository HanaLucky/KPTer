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

    /**
     カードを作成します。
     - parameter title: カード名
     - parameter detail: カード詳細
     - returns: カード
     */
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
    
    /**
     カードを編集します。
     - parameter card: カード
     - parameter editCard: 編集内容を持ったカード
     */
    class func edit(card: Card, editCard: Card){
        let realm = try! Realm()
        try! realm.write {
            card.card_title = editCard.card_title
            card.detail = editCard.detail
            card.type = editCard.type
        }
    }
    
    /**
     カードを削除します。
     - parameter card: 削除するカード
     */
    class func delete(card: Card){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(card)
        }
    }
    
    /**
     カードの関連を追加します。
     - parameter fromId: ひも付け元カードのID
     - parameter toId: ひも付け先カードのID
     */
    class func addCardRelation(fromId: String, toId: String) {
        let cardRelation = CardRelation()
        cardRelation.from_id = fromId
        cardRelation.to_id = toId
        let realm = try! Realm()
        try! realm.write {
            realm.add(cardRelation)
        }
    }
    
    /**
     カードの関連を削除します。
     - parameter tryCard: ひも付け元カード
     */
    class func deleteCardRelation(tryCard: Card) {
        let realm = try! Realm()
        let cardRelation = realm.objects(CardRelation).filter("to_id = '\(tryCard.id)'")
        try! realm.write {
            realm.delete(cardRelation)
        }
    }
    
    /**
     カードの関連を複数削除します。
     - parameter tryCard: ひも付け元カード
     */
    class func deleteCardRelations(tryCards: Array<Card>) {
        let realm = try! Realm()
        for tryCard in tryCards {
            let cardRelations = realm.objects(CardRelation).filter("to_id = '\(tryCard.id)'")
            try! realm.write {
                realm.delete(cardRelations)
            }
        }
    }
    
    /**
     カードの紐付き元を取得します。
     - parameter tryCard: ひも付け先カード
     */
    class func findCardRelation(tryCard: Card) -> Card {
        let realm = try! Realm()
        let cardRelation = realm.objects(CardRelation).filter("to_id = '\(tryCard.id)'")
        let card = realm.objects(Card).filter("id = '\(cardRelation.first!.from_id)'").first
        return card!
    }
    
    /**
     カードの紐付き先を取得します。
     紐付き先が存在しない場合はnilを返却する。
     - parameter card: ひも付け元カード
     */
    class func findFromCardRelations(card: Card) -> Array<Card>? {
        let realm = try! Realm()
        let cardRelations: Results! = realm.objects(CardRelation).filter("from_id = '\(card.id)'")
        if (cardRelations.isEmpty) {
            return nil
        }
        var cards: Array = [Card]()
        for cardRelation in cardRelations {
            let card = realm.objects(Card).filter("id = '\(cardRelation.to_id)'").first
            cards.append(card!)
        }
        return cards
    }
    
    /**
     カードのステータスを変更します。
     - parameter card: カード
     - parameter status: 変更したいステータスのEnum値
     */
    class func changeStatus(card: Card, status: Card.CardStatus){
        let realm = try! Realm()
        try! realm.write {
            card.status = status.rawValue
        }
    }
}