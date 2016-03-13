//
//  Card.swift
//  KPTer
//
//  Created by Kaori Sawamura on 2/28/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//

import Foundation
import CoreData


class Card: Board {
    class func create(title: String, detail: String) -> Card? {
        let newCard: Card! = Card.MR_createEntity()
        newCard.card_title = title
        newCard.detail = detail
        newCard.managedObjectContext!.MR_saveToPersistentStoreAndWait()
        return newCard
    }
    
    override func edit(title: String){
        card_title = title
        managedObjectContext!.MR_saveToPersistentStoreAndWait()
    }

}
