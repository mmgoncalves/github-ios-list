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
    
    var title: String {
        switch self {
        case .parseToObject:
            return "Error"
        default:
            return "Error"
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .parseToObject:
            return "Error to parse data to object"
        default:
            return "error not found"
        }
    }
}
