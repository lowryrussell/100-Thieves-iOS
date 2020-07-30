//
//  FirstViewController.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/6/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerImage: UIImageView!
    
    let headerViewMaxHeight: CGFloat = 300
    var headerViewMinHeight: CGFloat = 44
    
    var parallaxOffsetSpeed: CGFloat = 30
    var cellHeight: CGFloat = 225
    
    var parallaxImageHeight: CGFloat {
        let maxOffset = (sqrt(pow(cellHeight, 2) + 4 * parallaxOffsetSpeed * self.tableView.frame.height) - cellHeight) / 2
        return maxOffset + self.cellHeight
    }
    
    var lookbooks: [Lookbook]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        let lookbookCell = UINib(nibName: "LookbookTableViewCell", bundle: nil)
        tableView.register(lookbookCell, forCellReuseIdentifier: "LookbookCell")
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        headerViewMinHeight += window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        self.startLoading()
        LookbooksApi().getLookbooks { (lookbooksResponse) in
            self.stopLoading()
            guard let lookbooks = lookbooksResponse.lookbooks else { return }
            self.lookbooks = lookbooks
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let lookbooks = lookbooks else { return 0 }
        return lookbooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LookbookCell", for: indexPath) as? LookbookTableViewCell else {
            fatalError("Can't dequeue LookbookTableViewCell")
        }
        cell.setupCell(lookbook: lookbooks[indexPath.row])
        
        cell.backgroundImageHeight.constant = self.parallaxImageHeight
        cell.backgroundImageTopConstraint.constant = parallaxOffset(newOffsetY: tableView.contentOffset.y, cell: cell)
        
        tableViewHeightConstraint.constant = tableView.contentSize.height
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
}

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        let newHeaderViewHeight: CGFloat = headerViewHeightConstraint.constant - y

        if newHeaderViewHeight > headerViewMaxHeight {
            headerViewHeightConstraint.constant = headerViewMaxHeight
        } else if newHeaderViewHeight < headerViewMinHeight {
            headerViewHeightConstraint.constant = headerViewMinHeight
        } else {
            headerViewHeightConstraint.constant = newHeaderViewHeight
            scrollView.contentOffset.y = 0 // block scroll view
        }
        
        let offsetY = tableView.contentOffset.y
        for cell in tableView.visibleCells as! [LookbookTableViewCell] {
            cell.backgroundImageTopConstraint.constant = parallaxOffset(newOffsetY: offsetY, cell: cell)
        }
    }
    
    func parallaxOffset(newOffsetY: CGFloat, cell: LookbookTableViewCell) -> CGFloat {
        return (newOffsetY - cell.frame.origin.y) / parallaxImageHeight * parallaxOffsetSpeed
    }
}

