//
//  Notifier.swift
//  StackOverflowApp
//
//  Created by Mohanasundaram on 10/01/20.
//  Copyright © 2020 AmsSanjeevi. All rights reserved.
//


import UIKit

class Notifier: UIViewController {
    
    static let sharedInstance = Notifier()
    
    func showAlert(alertTitle: String, message: String, firstButtonTitle: String, secondButtonTitle: String? = nil, firstAction: (() -> Void)? = nil, secondAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let firstButton = UIAlertAction(title: firstButtonTitle, style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
            if let firstAction = firstAction { firstAction() }
        }
        alert.addAction(firstButton)
        if let secondButtonTitle = secondButtonTitle {
            let secondButton = UIAlertAction(title: secondButtonTitle, style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
                if let secondAction = secondAction { secondAction() }
            }
            alert.addAction(secondButton)
        }
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator(title: String) {
        let overlay = addScreenOverlay()
        view.bringSubviewToFront(overlay)
        let spinner = getSpinner()
        let backGround = getBackgroundView()
        let infoLabel = getActivityInfoLabel(with: title)
        overlay.addSubview(backGround)
        overlay.spinnerBackGroundConstraints(background: backGround)
        backGround.addSubview(spinner)
        backGround.addSubview(infoLabel)
        spinner.scale(to: 3)
        backGround.spinnerConstraints(spinner: spinner, label: infoLabel)
        backGround.applyCornerRadius(of: Constants.Sizing.StandardCornerRadius)
        backGround.addBorder(borderColor: Colors.AppTheme)
        spinner.startAnimating()
    }
    
    func addScreenOverlay() -> UIView {
        if let rootView = UIApplication.shared.keyWindow?.rootViewController?.view {
            if let overlay = rootView.viewWithTag(3000) {
                return overlay
            } else {
                let overlay = UIView()
                overlay.frame = UIScreen.main.bounds
                overlay.backgroundColor = Colors.Overlay
                overlay.tag = 3000
                rootView.addSubview(overlay)
                return overlay
            }
        } else {
            return UIView()
        }
    }
    
    func getSpinner() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }
    
    func getBackgroundView() -> UIView {
        let backGroundView = UIView()
        backGroundView.backgroundColor = Colors.White
        return backGroundView
    }
    
    func getActivityInfoLabel(with title: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.text = title
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func removeNotifier() {
        let window = UIApplication.shared.keyWindow
        window?.rootViewController?.view.viewWithTag(3000)?.removeFromSuperview()
    }
}

