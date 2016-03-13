//
//  CardRelation+CoreDataProperties.swift
//  KPTer
//
//  Created by Kaori Sawamura on 2/28/16.
//  Copyright © 2016 HanaLucky. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CardRelation {

    @NSManaged var relation_id: NSNumber?
    @NSManaged var from_id: NSNumber?
    @NSManaged var to_id: NSNumber?

}
