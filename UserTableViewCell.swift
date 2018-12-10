//
//  UserTableViewCell.swift
//  pug-ios
//
//  Created by Bryan Ward & Jeffrey Bahns on 5/3/17.
//  Copyright © 2017 Bryan Ward & Jeffrey Bahns. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func useUser(_ user: Player) {
        if let name = user.playerUsername() {
            usernameLabel.text = name
        }
        if let image = user.getImage() {
            userImage.image = image
            userImage.setRounded()
        }
    }
}
