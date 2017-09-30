//
//  CoreDataHelper.swift
//  github-ios-listTests
//
//  Created by Mateus Marques on 28/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import Foundation
import CoreData
@testable import github_ios_list

struct CoreDataHelper {
    static func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        let url = Bundle.main.url(forResource: "github_ios_list", withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: url)
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Error to create mock for NSManagedObjectContext")
        }
        
        let managedObjecContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjecContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjecContext
    }
}
