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

class RepositoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RepositoryViewModelDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: RepositoryViewModel!
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult>!
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedObjectContext = appDelegate?.persistentContainer.viewContext
        self.viewModel = RepositoryViewModel(context: self.managedObjectContext)
        self.viewModel.delegate = self
        
        initializeFetchResultController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initializeFetchResultController() {
        let request = NSFetchRequest<RepositoryEntity>(entityName: "RepositoryEntity")
        let sortByStars = NSSortDescriptor(key: "stars", ascending: false)
        request.sortDescriptors = [sortByStars]
        fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil) as! NSFetchedResultsController<NSFetchRequestResult>
        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch()
        } catch let error {
            print(error)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections!.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchResultController.sections else {
            fatalError("FetchResultController is empty")
        }
        
        return sections[section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "repositoryTableViewCell", for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        guard let repository = fetchResultController?.object(at: indexPath) as? RepositoryEntity else {
            fatalError("FetchResutController has error")
        }
        
        cell.authorLabel.text = repository.owner?.name
        cell.nameRepository.text = repository.name
        cell.descriptionRepository.text = ""
        cell.startLabel.text = repository.stars.description
        cell.forksLabel.text = repository.forks.description
        
        if let imageString = repository.owner?.avatarUrl {
            let url = URL(string: imageString)
            cell.avatar.kf.setImage(with: url)
        }
        
        return cell
    }
    
    //MARK: repositoryViewModelDelegate
    func onFinish() {
        self.initializeFetchResultController()
        tableView.reloadData()
    }

}

