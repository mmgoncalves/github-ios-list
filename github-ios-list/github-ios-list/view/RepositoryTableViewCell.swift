//
//  RepositoryTableViewCell.swift
//  github-ios-list
//
//  Created by Mateus Marques on 21/09/17.
//  Copyright © 2017 Mateus Marques. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameRepository: UILabel!
    @IBOutlet weak var descriptionRepository: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
