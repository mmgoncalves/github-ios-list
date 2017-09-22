//
//  RepositoryTest.swift
//  github-ios-listTests
//
//  Created by Mateus Marques on 21/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import XCTest
@testable import github_ios_list

class RepositoryTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_should_decode_json_to_repository_object() {
        
//        let jsonFile = Bundle.main.path(forResource: "JSONrepository_mock", ofType: "json")
        let jsonUrl = Bundle.main.url(forResource: "JSONRepository_mock", withExtension: "json")
        let jsonData = try! Data(contentsOf: jsonUrl!)
        
        do {
            let myTest = try JSONDecoder().decode(JSONRepositoryItem.self, from: jsonData)
            print(myTest)
        } catch {
            print(error)
        }
        
    }
    
}
