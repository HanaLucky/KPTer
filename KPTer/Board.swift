//
//  Board.swift
//  KPTer
//
//  Created by Kaori Sawamura on 2/28/16.
//  Copyright © 2016 yoshikawa atsushi. All rights reserved.
//

import Foundation
import CoreData


class Board: NSManagedObject {
    
    class func create(title: String) -> Board? {
        let newBoard: Board! = Board.MR_createEntity()
        newBoard.board_title = title
        newBoard.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        return newBoard
    }
    
    func deleteBoard(){
        MR_deleteEntity()
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
    
    func edit(title: String){
        board_title = title
        managedObjectContext!.MR_saveToPersistentStoreAndWait()
    }
    
    func addCard(title: String, detail: String) {
        cards!.insert(Card.create(title, detail: detail)!)
    }
    
}
