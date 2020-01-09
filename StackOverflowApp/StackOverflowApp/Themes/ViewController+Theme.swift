//
//  ViewController+Theme.swift
//  StackOverflowApp
//
//  Created by admin on 07/01/20.
//  Copyright © 2020 Gofrugal Technologies. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setTabBar(color: UIColor, andFontOf size: CGFloat) {
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : color,
                                           NSAttributedString.Key.font : UIFont.systemFont(ofSize: size, weight: .semibold)], for: .selected)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: size, weight: .semibold)], for: .normal)
    }
    
    func addNavBarController(title: String) -> UINavigationController {
        let navBarController = UINavigationController(rootViewController: self)
        navBarController.navigationBar.barTintColor = Colors.AppTheme
        navBarController.navigationBar.topItem?.title = title
        return navBarController
    }
}
