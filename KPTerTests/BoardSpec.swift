//
//  BoardSpec.swift
//  KPTer
//
//  Created by Kaori Sawamura on 3/6/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import RealmSwift
import XCTest
import Quick
import Nimble
@testable import KPTer

// BoardViewModelのテストをする際は、CardSpecのspec()内をコメントアウトしてください。
class BoardSpec: QuickSpec {
    
    override func spec() {
        
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        var newBoard: Board? = BoardViewModel.create("new board title")
        //BoardViewModel.addCard(newBoard!, title: "newBoard card title", detail: "newBoard card detail")
        
        describe("新規Boardを作成する") {
            it("新規Boardを作成できること") {
                expect(newBoard).toNot(beNil())
            }
            it("Boardのboard_titleが引数に指定した文字列であること") {
                expect(newBoard!.board_title).to(equal("new board title"))
            }
        }

        describe("Cardの名前と種別を引数に指定し、Boardに紐付いたCardを作成する") {
            sleep(2)
            BoardViewModel.addKeepCard(newBoard!, title: "new card title", detail: "new card detail")
            BoardViewModel.addProblemCard(newBoard!, title: "new card title2", detail: "new card detail")
            BoardViewModel.addTryCard(newBoard!, title: "new card title3", detail: "new card detail", fromCard: newBoard!.cards.first!)
            
            it("Boardに紐付いたCardが取得できること") {
                expect(newBoard!.cards).toNot(beNil())
            }
//            it("Tryカードのorderが１であること") {
//                expect(BoardViewModel.findKeepCard(newBoard!).first!.order).to(equal(1))
//            }
        }
        
        describe("Cardのリレーションを処理する") {
            sleep(3)
                it("引数に渡したcardのidとrelationのidが一致すること") {
                let realm = try! Realm()
                expect(newBoard!.cards.first!.id).to(equal(realm.objects(CardRelation).first?.from_id))
            }
            
        }
        
        describe("Cardの表示順を変更する") {
            sleep(3)
            it("引数に渡したcardの元") {
                BoardViewModel.addKeepCard(newBoard!, title: "new card title2", detail: "new card detail")
                BoardViewModel.addKeepCard(newBoard!, title: "new card title3", detail: "new card detail")
                let cards = BoardViewModel.findKeepCard(newBoard!).sorted("order")
                let secondCard = cards[1]
                BoardViewModel.changeCardOrder(cards, from_card_row: 1, to_card_row: 0)
                expect(BoardViewModel.findKeepCard(newBoard!).sorted("order").first!.id).to(equal(secondCard.id))
            }
            
        }
        
        describe("Boardに紐づくKeepのCardを取得する") {
            sleep(3)
            let results = BoardViewModel.findKeepCard(newBoard!)
            it("引数に指定した種別のCardであること") {
                expect(results.first!.type).to(equal("Keep"))
            }

        }
        
        describe("Boardに紐づくProblemのCardを取得する") {
            sleep(3)
            let results = BoardViewModel.findProblemCard(newBoard!)
            it("引数に指定した種別のCardであること") {
                expect(results.first!.type).to(equal("Problem"))
            }
            
        }
        
        describe("Boardに紐づくTryのCardを取得する") {
            sleep(3)
            let results = BoardViewModel.findTryCard(newBoard!)
            it("引数に指定した種別のCardであること") {
                expect(results.first!.type).to(equal("Try"))
            }
            
        }

//        // findCardByType(board: Board, type: Card.CardType) @BoardViewModelをテスト
//        describe("Boardに紐づく引数に指定した種別のCardを取得する") {
//            sleep(3)
//            let results = BoardViewModel.findCardByType(newBoard!, type: Card.CardType.Keep)
//            it("引数に指定した種別のCardであること") {
//                expect(results.first!.type).to(equal("Keep"))
//            }
//            
//        }

        describe("既存のBoardを編集する") {
            sleep(2)
            it("Boardの名前を引数に指定し、Boardの名前を変更できること") {
                BoardViewModel.edit(newBoard!, title: "edit board title")
                let editBoard: Board? = realm.objects(Board).first
                expect(editBoard!.board_title).to(equal("edit board title"))
            }
        }
        
//        describe("種別ごとに表示順をソートする") {
//            sleep(2)
//            changeWholeCardsOrder(newBoard.cards, cards: List<Card>)
//            it("Boardの名前を引数に指定し、Boardの名前を変更できること") {
//                BoardViewModel.edit(newBoard!, title: "edit board title")
//                let editBoard: Board? = realm.objects(Board).first
//                expect(editBoard!.board_title).to(equal("edit board title"))
//            }
//        }

        describe("Boardを削除する") {
            
            it("削除されたBoardが取得できないこと/削除されたBoardに紐づくcardsが取得できないこと") {
                sleep(10)
                BoardViewModel.delete(newBoard!)
                expect(realm.objects(Board).count).to(equal(0)) //削除されたBoardが取得できないこと
                expect(realm.objects(Card).count).to(equal(0))  //削除されたBoardに紐づくcardsが取得できないこと
            }
        }
    }
}
 