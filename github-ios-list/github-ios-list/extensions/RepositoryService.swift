//
//  RepositoryService.swift
//  github-ios-list
//
//  Created by Mateus Marques on 02/10/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import Foundation
import Alamofire

enum RepositoryService: URLRequestConvertible {
    static let baseUrlString = "https://api.github.com"
    
    case searchRepositories(page: Int)
    case pullRequests(repositoryFullName: String)
    
    var method:HTTPMethod {
        switch self {
        case .searchRepositories, .pullRequests:
            return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters?) = {
            switch self {
            case .searchRepositories(let page):
                return ("/search/repositories?q=language:Swift&sort=stars&page=\(page)", nil)
            case .pullRequests(let repositoryFullName):
                return ("/repos/\(repositoryFullName)/pulls", nil)
            }
        }()
        
        let url = try RepositoryService.baseUrlString.asURL()
        var urlRequest = URLRequest( url: url.appendingPathComponent(result.path))
        urlRequest.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }
}
