//
//  UIViewExtension.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/9/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import UIKit

extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func addOnClick(target: Any, action: Selector) {
        self.isUserInteractionEnabled = true;
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapGesture)
    }
}
