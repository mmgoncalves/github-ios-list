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
    var operationQueue: OperationQueue = OperationQueue()

    required init?(context: NSManagedObjectContext) {
        self.managedObjectContext = context
        self.operationQueue.maxConcurrentOperationCount = 1
    }
    
    func getRepositories() -> [RepositoryEntity]? {
        //get repositories from coreData
        //if coreData is empty, create a operation to get repositories from API
        
        self.fetchRpositories() { jsonRepositories in
            if let repositories = jsonRepositories {
                RepositoryDAO.save(repositories: repositories, inContext: self.managedObjectContext) { error in
                    print("Finish saving repositories: \(error)")
                }
            }
        }
        //save the api response and return the repositories 
        return []
    }
    
    private func fetchRpositories(completion: @escaping ([JSONRepository]?) -> Void) {
        Alamofire.request(
            URL(string: "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=1")!,
            method: .get
        )
        .validate()
        .responseJSON { (response) -> Void in
            guard response.result.isSuccess, let data = response.data else {
                print("Error while fetching remote rooms: \(response.result.error)")
                completion(nil)
                return
            }
            
            do {
                let jsonRepositoryItem = try JSONDecoder().decode(JSONRepositoryItem.self, from: data)
                completion(jsonRepositoryItem.items)
            } catch {
                print("Malformed data received from fetchAllRooms service")
                completion(nil)
            }
        }
    }
}
