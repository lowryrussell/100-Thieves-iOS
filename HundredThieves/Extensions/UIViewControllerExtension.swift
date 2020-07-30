//
//  UIViewControllerExtension.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/11/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

var loadingView : UIView?

extension UIViewController {
    func showPopupDialog(withMessage message: String, withTitle title: String, withCompletion completion: @escaping (_ finished: Bool) -> Void) {
        let popupDialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { (action) in
            completion(true)
        }
        let closeButton = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        popupDialog.addAction(okButton)
        popupDialog.addAction(closeButton)
        present(popupDialog, animated: true, completion: nil)
    }
    
    func showPopupDialogClose(withMessage message: String, withTitle title: String) {
        let popupDialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeButton = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        popupDialog.addAction(closeButton)
        present(popupDialog, animated: true, completion: nil)
    }
    
    func startLoading() {
        let spinnerView = UIView.init(frame: self.view.bounds)
        spinnerView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        spinnerView.alpha = 0
        let indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40), type: .circleStrokeSpin, color: .white)
        indicator.startAnimating()
        indicator.center = self.view.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(indicator)
            self.view.addSubview(spinnerView)
            UIView.animate(withDuration: 0.25, animations: {
                spinnerView.alpha = 1
            })
        }
        
        loadingView = spinnerView
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25, animations: {
                loadingView?.alpha = 0
            }) { _ in
                loadingView?.removeFromSuperview()
                loadingView = nil
            }
        }
    }
}
