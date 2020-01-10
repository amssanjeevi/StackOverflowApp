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
    
    var footerInfoView: UIView!
    var spinner: UIActivityIndicatorView!
    var infoLabel: UILabel!
    var rootController: UIViewController? {
        return getRootController()
    }
    
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
        let spinner = spinnerView()
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
    
    func spinnerView() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.tintColor = Colors.AppTheme
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
    
    func footerActivityIndicator(info: String) {
        footerInfoView = UIView()
        footerInfoView.applyCornerRadius(of: 5)
        footerInfoView.backgroundColor = Colors.White
        footerInfoView.addBorder(borderColor: Colors.AppTheme)
        footerInfoView.slide(
            from: CGRect(x: 10, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width-20, height: Constants.Sizing.FooterIndicatorHeight),
            to: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width-20, height: Constants.Sizing.FooterIndicatorHeight),
            completion: nil
        )
        spinner = spinnerView()
        infoLabel = infoLabelView(info: info)
        footerInfoView.addSubview(spinner)
        footerInfoView.addSubview(infoLabel)
        spinner.startAnimating()
        footerInfoView.addFooterIconAndInfoConstraints(iconView: spinner, label: infoLabel)
        rootController?.view.addSubview(footerInfoView)
        getRootController()?.view.addSubview(footerInfoView)
        rootController?.view.bringSubviewToFront(footerInfoView)
        rootController?.view.footerInfoConstraints(footerInfoView: footerInfoView)
    }
    
    func removeFooterNotification(title: String) {
        infoLabel.text = "Completed"
        spinner.stopAnimating()
        footerInfoView.addBorder(borderColor: Colors.DarkGreen)
        footerInfoView.slide(
            from: footerInfoView.frame,
            to: CGRect(x: 10, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width-20, height: Constants.Sizing.FooterIndicatorHeight),
            delay: 3) { (_) in
                self.footerInfoView.removeFromSuperview()
        }
        
    }
    
    func removeNotifier() {
        let window = UIApplication.shared.keyWindow
        window?.rootViewController?.view.viewWithTag(3000)?.removeFromSuperview()
    }
    
    func infoLabelView(info: String) -> UILabel {
        let label = UILabel()
        label.addLineBreak(lineCount: 2)
        label.applyVerySmallTextTheme()
        label.text = info
        return label
    }
}

