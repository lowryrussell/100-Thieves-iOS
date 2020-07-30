//
//  SecondViewController.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/6/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import UIKit

class CreatorsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var parallaxOffsetSpeed: CGFloat = 30
    var cellHeight: CGFloat = 225
    
    var parallaxImageHeight: CGFloat {
        let maxOffset = (sqrt(pow(cellHeight, 2) + 4 * parallaxOffsetSpeed * self.tableView.frame.height) - cellHeight) / 2
        return maxOffset + self.cellHeight
    }
    
    var creator: Creator?
    var creators: [Creator]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let contentCreatorNib = UINib(nibName: "ContentCreatorTableViewCell", bundle: nil)
        tableView.register(contentCreatorNib, forCellReuseIdentifier: "ContentCell")
        
        self.startLoading()
        CreatorsApi().getCreators { (creatorsResponse) in
            self.stopLoading()
            guard let creators = creatorsResponse.creators else { return }
            self.creators = creators
            self.tableView.reloadData()
        }
    }
    
    @objc func streamClicked() {
        if self.creator?.platform == .twitch {
            let twitchUrl = URL(string: "twitch://stream/\(self.creator?.channelName ?? "")")
            if (UIApplication.shared.canOpenURL(twitchUrl!)) {
                self.showPopupDialog(withMessage: "Do you want to open \(self.creator?.name ?? "")'s Twitch channel?", withTitle: "Twitch") { (okClicked) in
                    UIApplication.shared.open(twitchUrl!, options: [:], completionHandler: nil)
                }
            } else {
                self.showPopupDialogClose(withMessage: "Darn!", withTitle: "You don't have the Twitch app installed.")
            }
        } else if self.creator?.platform == .youtube {
            let youtubeUrl = URL(string: "youtube://www.youtube.com/channel/\(self.creator?.channelName ?? "")")
            if (UIApplication.shared.canOpenURL(youtubeUrl!)) {
                self.showPopupDialog(withMessage: "Do you want to open \(self.creator?.name ?? "")'s Youtube channel?", withTitle: "Youtube") { (okClicked) in
                    UIApplication.shared.open(youtubeUrl!, options: [:], completionHandler: nil)
                }
            } else {
                self.showPopupDialogClose(withMessage: "Darn!", withTitle: "You don't have the Youtube app installed.")
            }
        } else {
            // open mixer
        }
    }
    
    @objc func twitterClicked() {
        let twitterUrl = URL(string: "twitter://user?screen_name=\(self.creator?.twitterHandle ?? "")")
        if (UIApplication.shared.canOpenURL(twitterUrl!)) {
            self.showPopupDialog(withMessage: "Do you want to open \(self.creator?.name ?? "")'s Twitter page?", withTitle: "Twitter") { (okClicked) in
                UIApplication.shared.open(twitterUrl!, options: [:], completionHandler: nil)
            }
        } else {
            self.showPopupDialogClose(withMessage: "Darn!", withTitle: "You don't have the Twitter app installed.")
        }
    }
    
    @objc func instagramClicked() {
        let instagramUrl = URL(string: "instagram://user?username=\(self.creator?.instagramHandle ?? "")")
        if (UIApplication.shared.canOpenURL(instagramUrl!)) {
            self.showPopupDialog(withMessage: "Do you want to open \(self.creator?.name ?? "")'s Instagram page?", withTitle: "Instagram") { (okClicked) in
                UIApplication.shared.open(instagramUrl!, options: [:], completionHandler: nil)
            }
        } else {
            self.showPopupDialogClose(withMessage: "Darn!", withTitle: "You don't have the Instagram app installed.")
        }
    }
}

extension CreatorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let creators = creators else { return 0 }
        return creators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as? ContentCreatorTableViewCell else {
            fatalError("Can't dequeue ContentCreatorTableViewCell")
        }
        
        cell.setupCell(creator: creators[indexPath.row])
        
        cell.backgroundImageHeight.constant = self.parallaxImageHeight
        cell.backgroundImageTopConstraint.constant = parallaxOffset(newOffsetY: tableView.contentOffset.y, cell: cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.creator = creators[indexPath.row]
        
        let cell = tableView.cellForRow(at: indexPath) as? ContentCreatorTableViewCell
        
        UIView.animate(withDuration: 0.35) {
            cell?.backgroundImage.alpha = 0.2
            cell?.socialView.alpha = 1
            cell?.nameStatusView.alpha = 0
        }
        
        cell?.socialView.streamImage.addOnClick(target: self, action: #selector(streamClicked))
        cell?.socialView.twitterImage.addOnClick(target: self, action: #selector(twitterClicked))
        cell?.socialView.instagramImage.addOnClick(target: self, action: #selector(instagramClicked))
    }
        
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.35) {
            (tableView.cellForRow(at: indexPath) as? ContentCreatorTableViewCell)?.backgroundImage.alpha = 0.55
            (tableView.cellForRow(at: indexPath) as? ContentCreatorTableViewCell)?.socialView.alpha = 0
            (tableView.cellForRow(at: indexPath) as? ContentCreatorTableViewCell)?.nameStatusView.alpha = 1
        }
    }
    
    func parallaxOffset(newOffsetY: CGFloat, cell: ContentCreatorTableViewCell) -> CGFloat {
        return (newOffsetY - cell.frame.origin.y) / parallaxImageHeight * parallaxOffsetSpeed
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = tableView.contentOffset.y
        for cell in tableView.visibleCells as! [ContentCreatorTableViewCell] {
            cell.backgroundImageTopConstraint.constant = parallaxOffset(newOffsetY: offsetY, cell: cell)
        }
    }
}

