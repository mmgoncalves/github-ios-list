//
//  PullRequestEntity+CoreDataProperties.swift
//  
//
//  Created by Mateus Marques on 30/10/17.
//
//

import Foundation
import CoreData


extension PullRequestEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PullRequestEntity> {
        return NSFetchRequest<PullRequestEntity>(entityName: "PullRequestEntity")
    }

    @NSManaged public var body: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var owner: OwnerEntity?
    @NSManaged public var repository: RepositoryEntity?

}
