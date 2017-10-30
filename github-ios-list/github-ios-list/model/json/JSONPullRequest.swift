//
//  JSONPullRequest.swift
//  github-ios-list
//
//  Created by Mateus Marques on 21/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import Foundation

struct JSONPullRequest: Codable {
    var id: Int64
    var created_at: String
    var url: String
    var body: String
    var title: String
    var head: Head
}

struct Head: Codable {
    var user: JSONUser
    var repo: JSONRepository
}
