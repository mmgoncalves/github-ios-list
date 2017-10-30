//
//  RepositoryViewModel.swift
//  github-ios-list
//
//  Created by Mateus Marques on 21/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import CoreData
import Alamofire

class RepositoryViewModel {
    
    var managedObjectContext: NSManagedObjectContext!
    var repositories: [RepositoryEntity]! = []
    
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult>!
    var fetchResultControllerDelegate: NSFetchedResultsControllerDelegate!
    
    var serviceDelegate: ServiceDelegate?

    required init?(context: NSManagedObjectContext) {
        self.managedObjectContext = context
        
        self.getRepositories()
        self.repositories = RepositoryDAO.all(inContext: self.managedObjectContext)
    }
    
    private func getRepositories() {
        if Generic.isConnectedToNetwork() {
            Service.getRepository(withPage: 0, context: self.managedObjectContext) { error in
                if error == nil {
                    self.serviceDelegate?.onFinish()
                }
            }
        }
    }
    
    func initializeFetchResultController() {
        let request = NSFetchRequest<RepositoryEntity>(entityName: "RepositoryEntity")
        let sortByStars = NSSortDescriptor(key: "stars", ascending: false)
        request.sortDescriptors = [sortByStars]
        fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil) as! NSFetchedResultsController<NSFetchRequestResult>
        fetchResultController.delegate = self.fetchResultControllerDelegate
        
        do {
            try fetchResultController.performFetch()
        } catch let error {
            print(error)
        }
    }
    
}
