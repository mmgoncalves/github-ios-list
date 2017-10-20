//
//  Errors.swift
//  github-ios-list
//
//  Created by Mateus Marques on 01/10/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import Foundation

protocol AppError: LocalizedError {
    var title: String {get}
}

enum RepositoryError: AppError {
    
    case parseToObject
    case saveRepositories(localizedError: String)
    
    var title: String {
        switch self {
        case .parseToObject:
            return "Error"
        case .saveRepositories:
            return "Error while saving"
        
        default:
            return "Error"
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .parseToObject:
            return "Error to parse data to object"
        case .saveRepositories(let localizedError):
            return "Error description: \(localizedError)"
        default:
            return "error not found"
        }
    }
}
