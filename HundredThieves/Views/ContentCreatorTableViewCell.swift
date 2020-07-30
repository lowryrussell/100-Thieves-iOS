//
//  ContentCreatorTableViewCell.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/7/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import UIKit

class ContentCreatorTableViewCell: UITableViewCell {

    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var creatorName: UILabel!
    @IBOutlet var onlineStatus: UILabel!
    @IBOutlet weak var backgroundImageHeight: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var socialView: SocialView!
    @IBOutlet var nameStatusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundImage.clipsToBounds = true
        socialView.alpha = 0
        backgroundImage.alpha = 0.55
        nameStatusView.alpha = 1
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        socialView.alpha = 0
        backgroundImage.alpha = 0.55
        nameStatusView.alpha = 1
        tearDownSocialView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func tearDownSocialView() {
        socialView.streamImage.image = nil
    }
    
    func setupCell(creator: Creator) {
        backgroundImage.image = UIImage(named: creator.image!)
        creatorName.text = creator.name
        if creator.platform == .twitch {
            socialView.streamImage.image = UIImage(named: "twitch")
        } else if creator.platform == .youtube {
            socialView.streamImage.image = UIImage(named: "youtube")
        }
        socialView.setupSocialIcons()
        if creator.status == .live {
            onlineStatus.text = "Live"
            setupStatusBadge(isOnline: true)
        } else {
            onlineStatus.text = "Offline"
            setupStatusBadge(isOnline: false)
        }
    }
    
    func setupStatusBadge(isOnline: Bool) {
        onlineStatus.layer.cornerRadius = 5
        onlineStatus.clipsToBounds = true
        if isOnline {
            onlineStatus.text = "Live"
            onlineStatus.backgroundColor = .red
        } else {
            onlineStatus.text = "Offline"
            onlineStatus.backgroundColor = .lightGray
        }
        
    }
}
