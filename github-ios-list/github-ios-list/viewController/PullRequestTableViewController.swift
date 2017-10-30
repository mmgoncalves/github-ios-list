//
//  PullRequestTableViewController.swift
//  github-ios-list
//
//  Created by Mateus Marques on 21/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class PullRequestTableViewController: UITableViewController, ServiceDelegate {

    var managedObjectContext: NSManagedObjectContext!
    var repository: RepositoryEntity!
    var viewModel: PullRequestViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = PullRequestViewModel(context: self.managedObjectContext, repository: self.repository)
        self.viewModel.serviceDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    func onFinish() {
        self.tableView.reloadData()
    }

}
