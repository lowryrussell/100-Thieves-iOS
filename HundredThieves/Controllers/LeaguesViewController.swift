//
//  LeaguesViewController.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/12/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import UIKit

class LeaguesViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var leagues: Leagues!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

//        let leaguesCell = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
//        tableView.register(leaguesCell, forCellReuseIdentifier: "LeaguesCell")
        
        self.startLoading()
        LeaguesApi().getLeagues() { (leaguesResponse) in
            self.stopLoading()
            self.leagues = leaguesResponse
            self.tableView.reloadData()
        }
    }

}

extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let players = self.leagues.leagues![section].players else { return 0 }
        return players.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let leagues = self.leagues else { return 0 }
        return leagues.leagues!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesCell", for: indexPath)
        
        let league = self.leagues.leagues![indexPath.section]
        let player = league.players![indexPath.row]
        
        cell.textLabel?.font = UIFont(name: "Futura-Medium", size: 14)
        cell.textLabel?.text = player.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return leagues.leagues![section].name
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont(name: "Futura-Bold", size: 16)
        header.textLabel?.frame = header.frame
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let league = self.leagues.leagues![indexPath.section]
        let player = league.players![indexPath.row]
        
        let cell = tableView.cellForRow(at: indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(title: "Social", message: "Visit \(player.name ?? "")'s social profile", preferredStyle: .actionSheet)
        
        let twitterAction = UIAlertAction(title: "Twitter", style: .default) { (action) in
            let twitterUrl = URL(string: "twitter://user?screen_name=\(player.socials?.twitter ?? "")")
            UIApplication.shared.open(twitterUrl!, options: [:], completionHandler: nil)
        }
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        
        alert.addAction(twitterAction)
        alert.addAction(closeAction)
        
        // If this AlertController is presented inside a popover, it must provide the location information, either a sourceView and sourceRect or a barButtonItem.
        alert.popoverPresentationController?.sourceView = cell?.contentView
        alert.popoverPresentationController?.sourceRect = cell!.contentView.frame
        
        self.present(alert, animated: true, completion: nil)

    }
    
}
