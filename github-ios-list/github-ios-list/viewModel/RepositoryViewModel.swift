//
//  RepositoryViewModel.swift
//  github-ios-list
//
//  Created by Mateus Marques on 21/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import CoreData
import Alamofire

protocol RepositoryViewModelDelegate {
    func onFinish() -> Void
}

class RepositoryViewModel {
    
    var managedObjectContext: NSManagedObjectContext!
    var repositories: [RepositoryEntity]! = []
    
    var delegate: RepositoryViewModelDelegate?

    required init?(context: NSManagedObjectContext) {
        self.managedObjectContext = context
        
        self.getRepositories()
        self.repositories = RepositoryDAO.all(inContext: self.managedObjectContext)
    }
    
    private func getRepositories() {
        if Generic.isConnectedToNetwork() {
            RepositoryService.sync(page: 3, context: self.managedObjectContext) { error in
                if error == nil {
                    self.delegate?.onFinish()
                }
            }
        }
    }
    
}
