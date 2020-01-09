//
//  ViewController+Common.swift
//  StackOverflowApp
//
//  Created by admin on 06/01/20.
//  Copyright © 2020 Gofrugal Technologies. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addTabBarItem(title: String, iconName: String, tag: Int) {
        tabBarItem = UITabBarItem(title: title, image: UIImage(named: iconName), tag: tag)
        setTabBar(color: Colors.White, andFontOf: Constants.FontSize.Small)
    }
    
    func addRightBarButton(title: String, icon: IconFont.IconName?, target: AnyObject?, selector: Selector?) {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = icon == nil ? title : "\(IconFont.sharedInstance.getIconFont(name: icon!)) \(title)"
        barButtonItem.target = target
        barButtonItem.action = selector
        let attributes = [
            NSAttributedString.Key.font : UIFont(name: Constants.CustomFont, size: Constants.FontSize.Small),
        ]
        barButtonItem.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        barButtonItem.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: UIControl.State.selected)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = barButtonItem
    }
    
    func addAlertViewController(title: String, message: String, selected: String?, alertActions: [UIAlertAction], style: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertActions.forEach {
            alertController.addAction($0)
            if selected == $0.title { $0.setValue(Colors.DarkGreen, forKey: "titleTextColor") }
        }
        present(alertController, animated: true, completion: nil)
    }
    
}
