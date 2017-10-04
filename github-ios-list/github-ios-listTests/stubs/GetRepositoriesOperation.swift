//
//  GetRepositoriesOperation.swift
//  github-ios-list
//
//  Created by Mateus Marques on 01/10/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import CoreData
import Alamofire

class GetRepositoriesOperation: NetworkOperations {
    
    var managedObjectContext: NSManagedObjectContext!
    var onFinish: ((_ error: LocalizedError?) -> Void)?
    
    init(context: NSManagedObjectContext, requester: AlamofireRequester) {
        super.init(requester: requester)
        self.managedObjectContext = context
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        requester.makeRequest(RepositoryService.searchRepositories(page: 1)) { (response) in
            guard let items = response.data["items"] as? Data else {
                if let onFinish = self.onFinish {
                    onFinish(response.error)
                }
                self.finish()
                return
            }
            
            do {
                let repositories = try JSONDecoder().decode([JSONRepository].self, from: items)
                
                RepositoryDAO.save(repositories: repositories, inContext: self.managedObjectContext) { error in
                    if let onFinish = self.onFinish {
                        onFinish(nil)
                    }
                }
            } catch {
                if let onFinish = self.onFinish {
                    onFinish(nil)
                }
                
                self.finish()
            }
        }
    }
}
