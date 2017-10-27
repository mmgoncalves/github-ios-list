//
//  RepositoryDAOTest.swift
//  github-ios-listTests
//
//  Created by Mateus Marques on 28/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import XCTest
@testable import github_ios_list
import CoreData

class RepositoryDAOTest: XCTestCase {
    
    var repositories: [JSONRepository]!
    var context: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        self.repositories = StubRepository.getRepository()
        self.context = CoreDataHelper.setUpInMemoryManagedObjectContext()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_should_save_repository() {
        
        guard let _ = self.repositories else {
            XCTFail("self.repository is nil")
            return
        }

        RepositoryDAO.save(repositories: self.repositories, page: 0, inContext: self.context) { error in
            XCTAssertNil(error, "Error should be nil")
        }
    }
    
//    func test_should_fail_to_save_repository() {
//        let emptyRepositories: [JSONRepository] = []
//
//        RepositoryDAO.save(repositories: emptyRepositories, inContext: self.context) { error in
//            XCTAssertNotNil(error)
//        }
//    }
    
    func test_should_find_repository() {
        RepositoryDAO.save(repositories: self.repositories, page: 0, inContext: self.context) { error in
            XCTAssertNil(error, "Error should be nil")
            
            let repositories = RepositoryDAO.all(inContext: self.context)
            XCTAssertEqual(repositories?.count, 2)
        }
    }
    
}
