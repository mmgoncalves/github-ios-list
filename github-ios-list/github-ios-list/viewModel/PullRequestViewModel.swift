//
//  PullRequestViewModel.swift
//  github-ios-list
//
//  Created by Mateus Marques on 21/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import CoreData

class PullRequestViewModel {
    
    var managedObjectContext: NSManagedObjectContext!
    var repository: RepositoryEntity!
    
    required init?(context: NSManagedObjectContext, repository: RepositoryEntity) {
        self.managedObjectContext = context
        self.repository = repository
    }
    
    func getPullRequest() {
        
    }
    
}
