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
    
    /**
     ボードを作成します。
     - parameter title: ボード名
     - returns: ボード
     */
    class func create(title: String) -> Board? {
        let board = Board()
        board.board_title = title
        let realm = try! Realm()
        try! realm.write {
            realm.add(board)
        }
        return board
    }
    
    /**
     ボードを削除します。
     - parameter board: 削除するボード
     */
    class func delete(board: Board){
        let realm = try! Realm()
        try! realm.write {
            for card in board.cards {
                realm.delete(card)
            }
            realm.delete(board)
        }
    }
    
    /**
     ボードを編集します。
     - parameter board: ボード
     - parameter editBoard: 編集内容を持ったボード
     */
    class func edit(board: Board, editBoard: Board){
        let realm = try! Realm()
        try! realm.write {
            board.board_title = editBoard.board_title
        }
    }
    
    /**
     ボードの一覧を取得します。
     - parameter sortKey: ソートキー
     - parameter ascDesc: 昇順降順
     - returns: 全ボード
     */
    class func findBoards(sortKey: SortKey, ascDesc: AscDesc) -> Results<Board>{
        let realm = try! Realm()
        return realm.objects(Board).sorted(sortKey.rawValue, ascending: ModelViewUtilities.strToBool(ascDesc.rawValue))
    }
    
    /**
     Keepカードを追加します。
     - parameter board: ボード
     - parameter title: カードのタイトル
     - parameter detail: カードの詳細
     */
    class func addKeepCard(board: Board, title: String, detail: String) {
        BoardViewModel.addCard(board, title: title, detail: detail, type: Card.CardType.Keep)
    }
    
    /**
     Problemカードを追加します。
     - parameter board: ボード
     - parameter title: カードのタイトル
     - parameter detail: カードの詳細
     */
    class func addProblemCard(board: Board, title: String, detail: String) {
        BoardViewModel.addCard(board, title: title, detail: detail, type: Card.CardType.Problem)
    }
    
    /**
     Tryカードを追加します。
     - parameter board: ボード
     - parameter title: カードのタイトル
     - parameter detail: カードの詳細
     - parameter fromCard: 紐付き元カード
     */
    class func addTryCard(board: Board, title: String, detail: String, fromCard: Card) {
        let card = BoardViewModel.addCard(board, title: title, detail: detail, type: Card.CardType.Try)
        CardViewModel.addCardRelation(fromCard.id, toId: card.id)
    }
    
    /**
     Tryカードを追加します。
     - parameter board: ボード
     - parameter title: カードのタイトル
     - parameter detail: カードの詳細
     - parameter type: カードの種別
     - returns: カード
     */
    private class func addCard(board: Board, title: String, detail: String, type: Card.CardType) -> Card{
        let card = CardViewModel.create(title, detail: detail, type: type)
        let realm = try! Realm()
        try! realm.write {
            card!.order = board.cards.filter("type = '\(type)'").count + 1
            board.cards.append(card!)
        }
        return card!
    }
    
    /**
    Boardに紐づくKeepカードを取得します。
    - parameter board: ボード
    - returns: ボードに紐づくKeepカード
    */
    class func findKeepCard(board: Board) -> Results<Card> {
        return findCardByType(board, type: Card.CardType.Keep)
    }
    
    /**
    Boardに紐づくProblemカードを取得します。
    - parameter board: ボード
    - returns: ボードに紐づくKeepカード
    */
    class func findProblemCard(board: Board) -> Results<Card> {
        return findCardByType(board, type: Card.CardType.Problem)
    }

    /**
    Boardに紐づくTryカードを取得します。
    - parameter board: ボード
    - returns: ボードに紐づくKeepカード
    */
    class func findTryCard(board: Board) -> Results<Card> {
        return findCardByType(board, type: Card.CardType.Try)
    }
    
    /**
    Boardに紐づくカードを種別ごとに取得します。
    - parameter board: ボード
    - parameter type: 種別
    - returns: ボードに紐づく各種別のカード
    */
    private class func findCardByType(board: Board, type: Card.CardType) -> Results<Card> {
        return board.cards.filter("type = '\(type.rawValue)'").sorted("order")
    }
    
    /**
     カードの表示順を変更します。
     - parameter results: カードの一覧
     - parameter from_card_row: 移動元
     - parameter to_card_row: 移動先
     */
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


