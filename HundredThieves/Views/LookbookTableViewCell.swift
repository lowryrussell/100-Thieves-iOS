//
//  LookbookTableViewCell.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/7/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import UIKit

class LookbookTableViewCell: UITableViewCell {

    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var collectionName: UILabel!
    @IBOutlet var collectionDescription: UILabel!
    @IBOutlet weak var backgroundImageHeight: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageTopConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImage.clipsToBounds = true
        
        collectionDescription.numberOfLines = 2
        collectionDescription.sizeToFit()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(descriptionAction))
        collectionDescription.addGestureRecognizer(tap)
        collectionDescription.isUserInteractionEnabled = true
        self.selectionStyle = .none
        
        tap.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(lookbook: Lookbook) {
        let imageData = Data(base64Encoded: lookbook.image!)
        backgroundImage.image = UIImage(data: imageData!)
        collectionName.text = lookbook.name
        collectionDescription.text = lookbook.description
    }
    
    @objc func descriptionAction() {
        collectionDescription.numberOfLines = collectionDescription.numberOfLines == 0 ? 2 : 0
        UIView.animate(withDuration: 0.5) {
            self.collectionDescription.superview?.layoutIfNeeded()
        }
    }
    
}
