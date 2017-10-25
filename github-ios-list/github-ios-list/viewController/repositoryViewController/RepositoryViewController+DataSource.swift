//
//  RepositoryViewController+DataSource.swift
//  github-ios-list
//
//  Created by Mateus Marques on 25/10/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import UIKit

extension RepositoryViewController {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.fetchResultController.sections!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.viewModel.fetchResultController.sections else {
            fatalError("FetchResultController is empty")
        }
        
        return sections[section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "repositoryTableViewCell", for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        guard let repository = self.viewModel.fetchResultController?.object(at: indexPath) as? RepositoryEntity else {
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
}
