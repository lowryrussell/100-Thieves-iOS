//
//  SocialView.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/8/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import UIKit

class SocialView: NibView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var streamImage: UIImageView!
    @IBOutlet weak var twitterImage: UIImageView!
    @IBOutlet weak var instagramImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SocialView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    func setupSocialIcons() {
        streamImage.setImageColor(color: .white)
        twitterImage.setImageColor(color: .white)
        instagramImage.setImageColor(color: .white)
    }
}
