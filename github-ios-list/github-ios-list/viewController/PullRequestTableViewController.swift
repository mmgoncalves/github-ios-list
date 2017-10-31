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

class PullRequestTableViewController: UITableViewController, ServiceDelegate, NSFetchedResultsControllerDelegate {

    var managedObjectContext: NSManagedObjectContext!
    var repository: RepositoryEntity!
    var viewModel: PullRequestViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = PullRequestViewModel(context: self.managedObjectContext, repository: self.repository)
        self.viewModel.serviceDelegate = self
        self.viewModel.fetchResultControllerDelegate = self
        
        self.viewModel.initializeFethResultController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = viewModel.fetchResultController.sections else {
            fatalError("FetchResultController is empty")
        }
        
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = viewModel.fetchResultController.sections else {
            fatalError("FetchResultController is empty")
        }
        
        return sections[section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PullRequestTableViewCell", for: indexPath) as? PullRequestTableViewCell else {
            
            return UITableViewCell()
        }
        
        guard let pullRequest = viewModel.fetchResultController.object(at: indexPath) as? PullRequestEntity else {
            fatalError("FetchResultCOntroller is empty")
        }
        
        cell.authorLabel.text = pullRequest.owner?.name
        cell.bodyLabel.text = pullRequest.body
        cell.titleLabel.text = pullRequest.title
        cell.dateLabel.text = pullRequest.createdAt?.description
        
        if let imageString = pullRequest.owner?.avatarUrl {
            let url = URL(string: imageString)
            cell.avatar.kf.setImage(with: url)
        }
        
        return cell
    }

    func onFinish() {
        self.tableView.reloadData()
    }

}
