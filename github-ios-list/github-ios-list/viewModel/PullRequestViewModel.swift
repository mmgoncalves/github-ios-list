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
    var pullRequests: [PullRequestEntity]! = []
    
    var serviceDelegate: ServiceDelegate!
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult>!
    var fetchResultControllerDelegate: NSFetchedResultsControllerDelegate!
    
    required init?(context: NSManagedObjectContext, repository: RepositoryEntity) {
        self.managedObjectContext = context
        self.repository = repository
        
        self.getPullRequest()
        self.pullRequests = PullRequestDAO.find(byRepository: self.repository, inContext: self.managedObjectContext)
    }
    
    func getPullRequest() {
        if Generic.isConnectedToNetwork() {
            Service.getPullRequest(forRepository: self.repository, context: self.managedObjectContext) { (error) in
                if error == nil {
                    self.serviceDelegate.onFinish()
                }
            }
        }
    }
    
    func initializeFethResultController() {
        let request = NSFetchRequest<PullRequestEntity>(entityName: "PullRequestEntity")
        let sortByNumber = NSSortDescriptor(key: "number", ascending: false)
        
        request.sortDescriptors = [sortByNumber]
        fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil) as! NSFetchedResultsController<NSFetchRequestResult>
        
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error)
        }
    }
    
}
