//
//  OwnerEntity+CoreDataProperties.swift
//  
//
//  Created by Mateus Marques on 01/10/17.
//
//

import Foundation
import CoreData


extension OwnerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OwnerEntity> {
        return NSFetchRequest<OwnerEntity>(entityName: "OwnerEntity")
    }

    @NSManaged public var avatarUrl: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var pullRequests: NSSet?
    @NSManaged public var repositories: NSSet?

}

// MARK: Generated accessors for pullRequests
extension OwnerEntity {

    @objc(addPullRequestsObject:)
    @NSManaged public func addToPullRequests(_ value: PullRequestEntity)

    @objc(removePullRequestsObject:)
    @NSManaged public func removeFromPullRequests(_ value: PullRequestEntity)

    @objc(addPullRequests:)
    @NSManaged public func addToPullRequests(_ values: NSSet)

    @objc(removePullRequests:)
    @NSManaged public func removeFromPullRequests(_ values: NSSet)

}

// MARK: Generated accessors for repositories
extension OwnerEntity {

    @objc(addRepositoriesObject:)
    @NSManaged public func addToRepositories(_ value: RepositoryEntity)

    @objc(removeRepositoriesObject:)
    @NSManaged public func removeFromRepositories(_ value: RepositoryEntity)

    @objc(addRepositories:)
    @NSManaged public func addToRepositories(_ values: NSSet)

    @objc(removeRepositories:)
    @NSManaged public func removeFromRepositories(_ values: NSSet)

}
