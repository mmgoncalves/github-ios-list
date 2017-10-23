//
//  ViewController.swift
//  github-ios-list
//
//  Created by Mateus Marques on 21/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import UIKit
import CoreData

class RepositoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RepositoryViewModelDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: RepositoryViewModel!
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedObjectContext = appDelegate?.persistentContainer.viewContext
        self.viewModel = RepositoryViewModel(context: self.managedObjectContext)
        self.viewModel.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "repositoryTableViewCell", for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        let repository = viewModel.repositories[indexPath.row]
        cell.authorLabel.text = repository.owner?.name
        cell.nameRepository.text = repository.name
        cell.descriptionRepository.text = ""
        cell.startLabel.text = repository.stars.description
        cell.forksLabel.text = repository.forks.description
        
        return cell
    }
    
    //MARK: repositoryViewModelDelegate
    func onFinish() {
        tableView.reloadData()
    }

}

