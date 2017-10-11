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
    var page: Int!
    var onFinish: ((_ error: AppError?) -> Void)?
    
    init(page: Int, context: NSManagedObjectContext, requester: AlamofireRequester) {
        super.init(requester: requester)
        self.managedObjectContext = context
        self.page = page
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        requester.makeRequest(RepositoryService.searchRepositories(page: self.page)) { response in
            guard let items = response.data["items"] as? Data else {
                if let onFinish = self.onFinish {
                    onFinish(RepositoryError.parseToObject)
                }
                self.finish()
                return
            }
            
            do {
                let repositories = try JSONDecoder().decode([JSONRepository].self, from: items)
                
                RepositoryDAO.save(repositories: repositories, inContext: self.managedObjectContext) { error in
                    if let onFinish = self.onFinish {
                        if let localizedDescription = error?.localizedDescription {
                            onFinish(RepositoryError.saveRepositories(localizedError: localizedDescription))
                        } else {
                            onFinish(nil)
                        }
                    }
                }
            } catch {
                if let onFinish = self.onFinish {
                    onFinish(RepositoryError.parseToObject)
                }
                
                self.finish()
            }
        }
    }
}
