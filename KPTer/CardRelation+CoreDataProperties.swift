//
//  CardRelation+CoreDataProperties.swift
//  KPTer
//
//  Created by Kaori Sawamura on 2/28/16.
//  Copyright © 2016 yoshikawa atsushi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CardRelation {

    @NSManaged var from_id: NSNumber?
    @NSManaged var to_id: NSNumber?

}
