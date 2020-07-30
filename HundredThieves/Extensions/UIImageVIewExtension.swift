//
//  UIImageVIewExtension.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/9/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import UIKit

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
