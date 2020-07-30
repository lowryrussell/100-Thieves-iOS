//
//  LeaguesTableViewCell.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/19/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {
    
    @IBOutlet var playerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(player: Player) {
        playerNameLabel.text = player.name
    }
    
}
