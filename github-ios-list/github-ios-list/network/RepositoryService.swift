//
//  RepositoryService.swift
//  github-ios-list
//
//  Created by Mateus Marques on 02/10/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import CoreData
import Alamofire

protocol ServiceDelegate {
    func onFinish() -> Void
}

struct Service {
    
    static func getRepository(withPage page: Int, context: NSManagedObjectContext, completion: @escaping (_ error: AppError?) -> Void) {
        
        Alamofire.request(Route.repository(withPage: page).get, method: .get)
            .validate()
            .responseJSON { (dataResponse) in
                guard dataResponse.result.isSuccess, let data = dataResponse.data else {
                    print("Error while fetching remote rooms: \(dataResponse.result.error)")
                    completion(RepositoryError.saveRepositories(localizedError: (dataResponse.result.error?.localizedDescription)!))
                    return
                }
                
                do {
                    let jsonRepositoryItem = try JSONDecoder().decode(JSONRepositoryItem.self, from: data)
                    
                    RepositoryDAO.save(repositories: jsonRepositoryItem.items, page: page, inContext: context) { error in
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
    
    static func getPullRequest(
        forRepository repository: RepositoryEntity,
        context: NSManagedObjectContext,
        completion: @escaping (_ error: AppError?) -> Void) {
        
        let projectName = repository.fullName
        
        Alamofire.request(Route.pullRequests(projectName: projectName!).get, method: .get)
        .validate()
            .responseJSON { (dataResponse) in
                guard dataResponse.result.isSuccess, let data = dataResponse.data else {
                    print("Error while fetching pull requests: \(dataResponse.result.error)")
                    completion(PullRequestError.parseToObject)
                    return
                }
                
                do {
                    let jsonPullRequest = try JSONDecoder().decode([JSONPullRequest].self, from: data)
                    
                    PullRequestDAO.save(pullRequests: jsonPullRequest, inContext: context) { error in
                        if let error = error {
                            completion(PullRequestError.save(localizedError: error.localizedDescription))
                        } else {
                            completion(nil)
                        }
                    }
                } catch {
                    print("Malformed data received from service")
                    completion(PullRequestError.parseToObject)
                }
        }
    }
}
