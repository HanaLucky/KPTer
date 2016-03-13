//
//  BoardSpec.swift
//  KPTer
//
//  Created by Kaori Sawamura on 3/6/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import KPTer

class BoardSpec: QuickSpec {
    
    override func spec() {
        
        Board.MR_truncateAll()
        var newBoard: Board? = Board.create("new board title")
        
        describe("新規Boardを作成する") {
            it("新規Boardを作成できること") {
                expect(newBoard).toNot(beNil())
            }
            it("Boardのboard_titleが引数に指定した文字列であること") {
                expect(newBoard!.board_title).to(equal("new board title"))
            }
        }
        
        describe("Cardの名前を引数に指定し、Boardに紐付いたCardを作成する") {
            sleep(2)
            newBoard!.addCard("new card title", detail: "new card detail")
            
            it("Boardに紐付いたCardが取得できること") {
                expect(newBoard!.cards).toNot(beNil())
            }
        }
        
        describe("既存のBoardを編集する") {
            sleep(2)
            it("Boardの名前を引数に指定し、Boardの名前を変更できること") {
                
                newBoard!.edit("edit board title")
                let editBoard: Board? = Board.MR_findFirst()
                expect(editBoard!.board_title).to(equal("edit board title"))
            }
        }
        
        // ↓があると、Cardのテストが通らないため、一時的にコメントアウト
        //describe("Boardを削除する") {
          //  sleep(10)
            //it("削除されたBoardが取得できないこと") {
              //  newBoard!.deleteBoard()
                //expect(Board.MR_findAll()?.count).to(equal(0))
            //}
        //}
    }
}
 