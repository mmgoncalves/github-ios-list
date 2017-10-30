//
//  StubRepository.swift
//  github-ios-listTests
//
//  Created by Mateus Marques on 28/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import Foundation
import CoreData
@testable import github_ios_list

class StubRepository {
    static func getRepository() -> [JSONRepository]? {
        if let bundle = Bundle.allBundles.filter({ $0.path(forResource: "JSONRepository_mock", ofType: "json") != nil }).first {
            let jsonUrl = bundle.url(forResource: "JSONRepository_mock", withExtension: "json")
            let jsonData = try! Data(contentsOf: jsonUrl!)
            
            do {
                let repository = try JSONDecoder().decode(JSONRepositoryItem.self, from: jsonData)
                return repository.items
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func getRepositoryData() -> Data? {
        if let bundle = Bundle.allBundles.filter({ $0.path(forResource: "JSONRepository_mock", ofType: "json") != nil }).first {
            let jsonUrl = bundle.url(forResource: "JSONRepository_mock", withExtension: "json")
            let jsonData = try! Data(contentsOf: jsonUrl!)
            return jsonData
        } else {
            return nil
        }
    }
    
    static func getRepositoryEntity(context: NSManagedObjectContext) -> RepositoryEntity? {
        let repository = RepositoryEntity(context: context)
        repository.id = 123321123321
        repository.name = "test"
        repository.forks = 123
        repository.fullName = "test-full"
        repository.page = 1
        repository.stars = 123
        
        let owner = OwnerEntity(context: context)
        owner.id = 321321
        owner.name = "Owner name"
        owner.avatarUrl = ""

        repository.owner = owner
        
        context.saveSync { (error) in
            if error != nil {
                fatalError("ocorreu um erro: \(error?.localizedDescription)")
            }
        }
        
        return repository
    }
}
