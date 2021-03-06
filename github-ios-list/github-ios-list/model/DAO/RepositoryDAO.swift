//
//  RepositoryDAO.swift
//  github-ios-list
//
//  Created by Mateus Marques on 21/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import Foundation
import CoreData

class RepositoryDAO {
    
    static func save(repositories: [JSONRepository], page: Int, inContext: NSManagedObjectContext, completion: @escaping (_ error: Error?) -> Void) {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        privateContext.parent = inContext
        
        privateContext.performAndWait {
            for repository in repositories {
                let repositoryEntity = RepositoryEntity(context: privateContext)
                repositoryEntity.id = repository.id
                repositoryEntity.name = repository.name
                repositoryEntity.fullName = repository.full_name
                repositoryEntity.forks = repository.forks
                repositoryEntity.stars = repository.stargazers_count
                repositoryEntity.page = Int16(page)
                
                let owner = OwnerEntity(context: privateContext)
                owner.id = repository.owner.id
                owner.name = repository.owner.login
                owner.avatarUrl = repository.owner.avatar_url
                
                repositoryEntity.owner = owner
            }
            
             privateContext.saveSync(completion: { (error) in
                completion(error)
            })
        }
    }
    
    static func all(inContext: NSManagedObjectContext) -> [RepositoryEntity]? {
        let fetchRequest: NSFetchRequest<RepositoryEntity> = RepositoryEntity.fetchRequest()
        
        do {
            let repositories = try inContext.fetch(fetchRequest) as [RepositoryEntity]
            return repositories
        } catch {
            print("Error to find repositories: \(error)")
            return nil
        }
    }
    
    static func findOne(byId id: Int64, inContext: NSManagedObjectContext) -> RepositoryEntity? {
        let fetchRequest: NSFetchRequest<RepositoryEntity> = RepositoryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [id])
        
        do {
            let repositories = try inContext.fetch(fetchRequest) as [RepositoryEntity]
            return repositories.first
        } catch {
            print("Error to find repository")
            return nil
        }
    }
}
