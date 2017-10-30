//
//  ViewController.swift
//  github-ios-list
//
//  Created by Mateus Marques on 21/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class RepositoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ServiceDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: RepositoryViewModel!
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedObjectContext = appDelegate?.persistentContainer.viewContext
        self.viewModel = RepositoryViewModel(context: self.managedObjectContext)
        self.viewModel.serviceDelegate = self
        self.viewModel.fetchResultControllerDelegate = self
        
        self.viewModel.initializeFetchResultController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: PrepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            print("Error to get selected row")
           return
        }
        
        guard let repository = self.viewModel.fetchResultController.object(at: indexPath) as? RepositoryEntity else {
            print("Error to get repository")
            return
        }
        
        guard let destinationViewController = segue.destination as? PullRequestTableViewController else {
            print("Error to get pullRequestViewController")
            return
        }
        
        destinationViewController.managedObjectContext = self.managedObjectContext
        destinationViewController.repository = repository
    }
}

