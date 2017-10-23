//
//  RepositoryService.swift
//  github-ios-list
//
//  Created by Mateus Marques on 02/10/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import CoreData
import Alamofire

struct RepositoryService {
    
    static func sync(page: Int, context: NSManagedObjectContext, completion: @escaping (_ error: AppError?) -> Void) {
        
        Alamofire.request("https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=\(page)", method: .get)
            .validate()
            .responseJSON { (dataResponse) in
                guard dataResponse.result.isSuccess, let data = dataResponse.data else {
                    print("Error while fetching remote rooms: \(dataResponse.result.error)")
                    completion(RepositoryError.saveRepositories(localizedError: (dataResponse.result.error?.localizedDescription)!))
                    return
                }
                
                do {
                    let jsonRepositoryItem = try JSONDecoder().decode(JSONRepositoryItem.self, from: data)
                    
                    RepositoryDAO.save(repositories: jsonRepositoryItem.items, inContext: context) { error in
                        if let error = error {
                            completion(RepositoryError.saveRepositories(localizedError: error.localizedDescription))
                        } else {
                            completion(nil)
                        }
                        
                    }
                } catch let error {
                    print("Malformed data received from fetchAllRooms service")
                    completion(RepositoryError.saveRepositories(localizedError: error.localizedDescription))
                }
        }
    }
}
