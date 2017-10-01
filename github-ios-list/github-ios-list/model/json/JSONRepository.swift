//
//  JSONRepository.swift
//  github-ios-list
//
//  Created by Mateus Marques on 21/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import Foundation

struct JSONRepository: Codable {
    var id: Int64
    var name: String
    var forks: Int64
    var stargazers_count: Int64
    var owner: JSONOwner
}
