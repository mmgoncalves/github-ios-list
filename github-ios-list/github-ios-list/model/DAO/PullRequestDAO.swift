//
//  PullRequestDAO.swift
//  github-ios-list
//
//  Created by Mateus Marques on 21/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import CoreData

class PullRequestDAO {
    static func save(pullRequests: [JSONPullRequest], inContext: NSManagedObjectContext, completion: @escaping (_ error: Error?) -> Void) {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        privateContext.parent = inContext
        
        privateContext.performAndWait {
            
            for pullRequest in pullRequests {
                let pullRequestEntity = PullRequestEntity(context: privateContext)
                pullRequestEntity.id = pullRequest.id
                pullRequestEntity.title = pullRequest.title
                pullRequestEntity.url = pullRequest.url
                pullRequestEntity.body = pullRequest.body
                
                if let date = Date.from(dateString: pullRequest.created_at) {
                    pullRequestEntity.createdAt = date
                }
                
                let owner = OwnerEntity(context: privateContext)
                owner.id = pullRequest.user.id
                owner.name = pullRequest.user.login
                owner.avatarUrl = pullRequest.user.avatar_url
                
                pullRequestEntity.owner = owner
            }
            
            privateContext.saveSync { (error) in
                completion(error)
            }
        }
    }
    
    static func all(inContext: NSManagedObjectContext) -> [PullRequestEntity]? {
        
        return []
    }
}
