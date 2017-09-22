//
//  JSONUser.swift
//  github-ios-list
//
//  Created by Mateus Marques on 22/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import Foundation

struct JSONUser: Codable {
    var id: Int64
    var login: String
    var avatar_url: String
}
