//
//  RepositoryViewController+Delegate.swift
//  github-ios-list
//
//  Created by Mateus Marques on 25/10/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import UIKit

extension RepositoryViewController {
    //MARK: repositoryViewModelDelegate
    func onFinish() {
        self.viewModel.initializeFetchResultController()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
    }
}
