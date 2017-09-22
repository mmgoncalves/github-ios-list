//
//  OwnerEntity+CoreDataProperties.swift
//  
//
//  Created by Mateus Marques on 21/09/17.
//
//

import Foundation
import CoreData


extension OwnerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OwnerEntity> {
        return NSFetchRequest<OwnerEntity>(entityName: "OwnerEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var avatarUrl: String?

}
