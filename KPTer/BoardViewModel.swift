//
//  BoardViewModel.swift
//  KPTer
//
//  Created by Kaori Sawamura on 3/21/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import Foundation
import RealmSwift

class BoardViewModel {
    
    enum AscDesc: String {
        case Asc = "true"
        case Desc = "false"
    }
    
    enum SortKey: String {
        case Title = "board_title"
        case CreatedAt = "created_at"
        case UpdatedAt = "updated_at"
    }
    
    class func create(title: String) -> Board? {
        let board = Board()
        board.board_title = title
        let realm = try! Realm()
        try! realm.write {
            realm.add(board)
        }
        return board
    }
    
    class func delete(board: Board){
        let realm = try! Realm()
        try! realm.write {
            for var i = board.cards.count - 1; i >= 0; i-- {
                realm.delete(board.cards.first!)
            }
            realm.delete(board)
        }
    }
    
    class func edit(board: Board, title: String){
        let realm = try! Realm()
        try! realm.write {
            board.board_title = title
        }
    }
    
    class func findBoards(sortKey: SortKey, ascDesc: AscDesc) -> Results<Board>{
        let realm = try! Realm()
        return realm.objects(Board).sorted(sortKey.rawValue, ascending: ModelViewUtilities.strToBool(ascDesc.rawValue))
    }
    
    class func addKeepCard(board: Board, title: String, detail: String) {
        let card = BoardViewModel.addCard(board, title: title, detail: detail, type: Card.CardType.Keep)
    }
    
    class func addProblemCard(board: Board, title: String, detail: String) {
        let card = BoardViewModel.addCard(board, title: title, detail: detail, type: Card.CardType.Problem)
    }
    
    class func addTryCard(board: Board, title: String, detail: String, fromCard: Card) {
        let card = BoardViewModel.addCard(board, title: title, detail: detail, type: Card.CardType.Try)
        addCardRelation(fromCard.id, toId: card.id)
    }
    
    private class func addCard(board: Board, title: String, detail: String, type: Card.CardType) -> Card{
        let card = CardViewModel.create(title, detail: detail, type: type)
        let realm = try! Realm()
        try! realm.write {
            card!.order = board.cards.filter("type = '\(type)'").count + 1
            board.cards.append(card!)
        }
        return card!
    }
    
    // Boardに紐づくKeep Cardを取得する
    class func findKeepCard(board: Board) -> Results<Card> {
        return findCardByType(board, type: Card.CardType.Keep)
    }
    
    // Boardに紐づくProblem Cardを取得する
    class func findProblemCard(board: Board) -> Results<Card> {
        return findCardByType(board, type: Card.CardType.Problem)
    }
    
    // Boardに紐づくTry Cardを取得する
    class func findTryCard(board: Board) -> Results<Card> {
        return findCardByType(board, type: Card.CardType.Try)
    }
    
    // Boardに紐づくCardをタイプ別に取得する
    private class func findCardByType(board: Board, type: Card.CardType) -> Results<Card> {
        return board.cards.filter("type = '\(type.rawValue)'")
    }
    
    private class func addCardRelation(fromId: String, toId: String) {
        let cardRelation = CardRelation()
        cardRelation.from_id = fromId
        cardRelation.to_id = toId
        let realm = try! Realm()
        try! realm.write {
            realm.add(cardRelation)
        }
    }
    
    class func changeCardOrder(results: Results<Card>, from_card_row: Int, to_card_row: Int) {
        var cards = Array(results)
        let movedCard = cards[from_card_row]
        cards.removeAtIndex(from_card_row)
        cards.insert(movedCard, atIndex: to_card_row)
        
        let realm = try! Realm()
        try! realm.write {
            for var i = 0; i < cards.count; i++ {
                cards[i].order = i + 1
            }
        }
    }

}


