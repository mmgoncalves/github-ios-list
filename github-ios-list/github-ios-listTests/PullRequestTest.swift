//
//  PullRequestTest.swift
//  github-ios-listTests
//
//  Created by Mateus Marques on 22/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import XCTest
@testable import github_ios_list

class PullRequestTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_should_decode_json_to_pullRequest_object() {
        if let bundle = Bundle.allBundles.filter({ $0.url(forResource: "JSONPullRequest_mock", withExtension: "json") != nil }).first {
            let jsonUrl = bundle.url(forResource: "JSONPullRequest_mock", withExtension: "json")
            let jsonData = try! Data(contentsOf: jsonUrl!)
            
            do {
                let pullRequest = try JSONDecoder().decode([JSONPullRequest].self, from: jsonData)
                
                XCTAssert(pullRequest.count == 2)
                XCTAssertEqual(pullRequest.first?.id, 140723716)
                XCTAssertEqual(pullRequest.last?.id, 139034869)
                
            } catch {
                XCTFail()
            }
        } else {
            XCTFail()
        }
    }
    
}
