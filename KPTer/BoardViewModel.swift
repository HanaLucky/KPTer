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
            realm.delete(board)
        }
    }
    
    class func edit(board: Board, title: String, detail: String){
        let realm = try! Realm()
        try! realm.write {
            board.board_title = title
        }
    }
    
    class func addCard(board: Board, title: String, detail: String) {
        //board.cards.append(CardViewModel.create(title, detail: detail)!)
    }

}


