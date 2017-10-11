//
//  RepositoryViewModelTest.swift
//  github-ios-listTests
//
//  Created by Mateus Marques on 04/10/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import XCTest
@testable import github_ios_list
import CoreData

class RepositoryViewModelTest: XCTestCase {
    
    var context: NSManagedObjectContext!
    var viewModel: RepositoryViewModel!
    
    override func setUp() {
        super.setUp()
        self.context = CoreDataHelper.setUpInMemoryManagedObjectContext()
        self.viewModel = RepositoryViewModel(context: self.context)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_should_fetch_repositories_and_save() {
        let _ = self.viewModel.getRepositories()
    }
 
    
}
