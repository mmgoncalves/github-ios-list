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
    var pullRequests: [JSONPullRequest]!
    
    override func setUp() {
        super.setUp()
        self.context = CoreDataHelper.setUpInMemoryManagedObjectContext()
        self.pullRequests = StubPullRequest.getPullRequests()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    private func createRepository() -> RepositoryEntity {
        let repository = RepositoryEntity(context: self.context)
        repository.id = 123321123321
        repository.name = "test"
        repository.forks = 123
        repository.fullName = "test-full"
        repository.page = 1
        repository.stars = 123
        
        return repository
    }
    
    func test_should_save_pullRequest() {
        guard let _ = self.pullRequests else {
            XCTFail("PullRequests should not be nil")
            return
        }
        
        let repository = self.createRepository()
        
        PullRequestDAO.save(pullRequests: self.pullRequests, repository: repository, inContext: self.context) { error in
            XCTAssertNil(error)
        }
    }
    
    func test_should_get_all_pullRequests() {
        guard let _ = self.pullRequests else {
            XCTFail("PullRequests should not be nil")
            return
        }
        
        let repository = self.createRepository()
        
        PullRequestDAO.save(pullRequests: self.pullRequests, repository: repository, inContext: self.context) { error in
            XCTAssertNil(error)
            
            let allPullRquests = PullRequestDAO.all(inContext: self.context)
            XCTAssertNotNil(allPullRquests)
            XCTAssertEqual(allPullRquests?.count, 2)
            
            XCTAssertNotNil(allPullRquests?.first?.id)
            XCTAssertNotNil(allPullRquests?.first?.title)
            XCTAssertNotNil(allPullRquests?.first?.url)
            XCTAssertNotNil(allPullRquests?.first?.body)
            XCTAssertNotNil(allPullRquests?.first?.repositoryId)
            XCTAssertNotNil(allPullRquests?.first?.createdAt)
            XCTAssertNotNil(allPullRquests?.first?.owner)
        }
    }
    
    func test_should_find_PullRequest_by_id() {
        guard let _ = self.pullRequests else {
            XCTFail("PullRequests should not be nil")
            return
        }
        
        let repository = self.createRepository()
        
        PullRequestDAO.save(pullRequests: self.pullRequests, repository: repository, inContext: self.context) { error in
            XCTAssertNil(error)
            let repositoryId: Int64 = 22458259
            
            let foundPullRequests = PullRequestDAO.find(byRepository: repository, inContext: self.context)
            
            XCTAssertNotNil(foundPullRequests)
            XCTAssertEqual(foundPullRequests?.count, 2)
            XCTAssertEqual(foundPullRequests?.first?.repositoryId, repositoryId)
        }
    }
    
}
