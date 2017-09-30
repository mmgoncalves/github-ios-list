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
        
        if let bundle = Bundle.allBundles.filter({ $0.path(forResource: "JSONRepository_mock", ofType: "json") != nil }).first {
            let jsonUrl = bundle.url(forResource: "JSONRepository_mock", withExtension: "json")
            let jsonData = try! Data(contentsOf: jsonUrl!)
            
            do {
                let repository = try JSONDecoder().decode(JSONRepositoryItem.self, from: jsonData)
                
                XCTAssert(repository.items.count == 2)
                XCTAssertEqual(repository.items.first?.name, "Alamofire")
                XCTAssertEqual(repository.items.last?.name, "awesome-ios")
            } catch {
                XCTFail()
            }
        } else {
            XCTFail()
        }
    }
    
}
