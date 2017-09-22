//
//  RepositoryEntity+CoreDataProperties.swift
//  
//
//  Created by Mateus Marques on 21/09/17.
//
//

import Foundation
import CoreData


extension RepositoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepositoryEntity> {
        return NSFetchRequest<RepositoryEntity>(entityName: "RepositoryEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var forks: Int64
    @NSManaged public var stars: Int64
    @NSManaged public var owner: OwnerEntity?
    @NSManaged public var pullRequest: NSSet?

}

// MARK: Generated accessors for pullRequest
extension RepositoryEntity {

    @objc(addPullRequestObject:)
    @NSManaged public func addToPullRequest(_ value: PullRequestEntity)

    @objc(removePullRequestObject:)
    @NSManaged public func removeFromPullRequest(_ value: PullRequestEntity)

    @objc(addPullRequest:)
    @NSManaged public func addToPullRequest(_ values: NSSet)

    @objc(removePullRequest:)
    @NSManaged public func removeFromPullRequest(_ values: NSSet)

}
