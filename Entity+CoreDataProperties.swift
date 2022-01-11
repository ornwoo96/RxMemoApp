//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by 김동우 on 2022/01/11.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var foodName: String?
    @NSManaged public var dang: String?

}
