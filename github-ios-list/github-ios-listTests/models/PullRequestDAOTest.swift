//
//  PullRequestDAOTest.swift
//  github-ios-listTests
//
//  Created by Mateus Marques on 30/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import XCTest
import CoreData
@testable import github_ios_list

class PullRequestDAOTest: XCTestCase {
    
    var context: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        self.context = CoreDataHelper.setUpInMemoryManagedObjectContext()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_should_save_pullRequest() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_should_find_PullRequest_by_id() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
