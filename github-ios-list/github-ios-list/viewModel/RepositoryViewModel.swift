//
//  RepositoryViewModel.swift
//  github-ios-list
//
//  Created by Mateus Marques on 21/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import CoreData

class RepositoryViewModel {
    
    var managedObjectContext: NSManagedObjectContext!
    var operationQueue: OperationQueue = OperationQueue()

    required init?(context: NSManagedObjectContext) {
        self.managedObjectContext = context
        self.operationQueue.maxConcurrentOperationCount = 1
    }
    
    func getRepositories() -> [RepositoryEntity]? {
        //get repositories from coreData
        //if coreData is empty, create a operation to get repositories from API
        
        //save the api response and return the repositories 
        return []
    }
}
