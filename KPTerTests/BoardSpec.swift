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
        Board.create("new board title")
        let newBoard: Board? = Board.MR_findFirst()
        
        describe("新規Boardを作成する newメソッド") {
            it("新規Boardを作成できること") {
                expect(newBoard).toNot(beNil())
            }
            it("Boardのboard_titleが引数に指定した文字列であること") {
                expect(newBoard!.board_title).to(equal("new board title"))
            }
        }
        
        describe("既存のBoardを編集する editメソッド") {
            sleep(5)
            it("Boardの名前を引数に指定し、Boardの名前を変更できること") {
                newBoard!.edit("edit board title")
                let editBoard: Board? = Board.MR_findFirst()
                expect(editBoard!.board_title).to(equal("edit board title"))
            }
        }
    }
}
 