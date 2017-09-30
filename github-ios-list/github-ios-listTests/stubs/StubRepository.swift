//
//  StubRepository.swift
//  github-ios-listTests
//
//  Created by Mateus Marques on 28/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import Foundation
@testable import github_ios_list

class StubRepository {
    static func getRepository() -> [JSONRepository]? {
        if let bundle = Bundle.allBundles.filter({ $0.path(forResource: "JSONRepository_mock", ofType: "json") != nil }).first {
            let jsonUrl = bundle.url(forResource: "JSONRepository_mock", withExtension: "json")
            let jsonData = try! Data(contentsOf: jsonUrl!)
            
            do {
                let repository = try JSONDecoder().decode(JSONRepositoryItem.self, from: jsonData)
                return repository.items
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
