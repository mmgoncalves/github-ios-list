//
//  PullRequestEntity+CoreDataProperties.swift
//  
//
//  Created by Mateus Marques on 21/09/17.
//
//

import Foundation
import CoreData


extension PullRequestEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PullRequestEntity> {
        return NSFetchRequest<PullRequestEntity>(entityName: "PullRequestEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var url: String?
    @NSManaged public var body: String?
    @NSManaged public var title: String?
    @NSManaged public var owner: OwnerEntity?
    @NSManaged public var repository: RepositoryEntity?

}
