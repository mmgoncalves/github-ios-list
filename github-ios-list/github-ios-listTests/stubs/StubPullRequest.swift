//
//  StubPullRequest.swift
//  github-ios-listTests
//
//  Created by Mateus Marques on 01/10/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import Foundation
@testable import github_ios_list

struct StubPullRequest {
    static func getPullRequests() -> [JSONPullRequest]? {
        if let bundle = Bundle.allBundles.filter({ $0.path(forResource: "JSONPullRequest_mock", ofType: "json") != nil }).first {
            let jsonUrl = bundle.url(forResource: "JSONPullRequest_mock", withExtension: "json")
            let jsonData = try! Data(contentsOf: jsonUrl!)
            
            do {
                let pullRequests = try JSONDecoder().decode([JSONPullRequest].self, from: jsonData)
                return pullRequests
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
