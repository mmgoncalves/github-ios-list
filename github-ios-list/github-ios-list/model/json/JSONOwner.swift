//
//  JSONOwner.swift
//  github-ios-list
//
//  Created by Mateus Marques on 21/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import Foundation

struct JSONOwner: Codable {
    var id: Int64
    var login: String
    var avatar_url: String
}
