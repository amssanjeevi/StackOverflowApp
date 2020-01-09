//
//  ViewController.swift
//  StackOverflowApp
//
//  Created by Mohanasundaram on 10/01/20.
//  Copyright © 2020 AmsSanjeevi. All rights reserved.
//

import UIKit

class ContainerViewController: UITabBarController {

    lazy var homeController: UINavigationController = {
        let homeVc = HomeViewController()
        homeVc.answerDelegate = self
        homeVc.addTabBarItem(title: "Home".localized, iconName: "Home", tag: 0)
        return homeVc.addNavBarController(title: "StackOverFlow".localized)
    }()
    
    lazy var searchController: UINavigationController = {
        let searchVc = SearchViewController()
        searchVc.addTabBarItem(title: "Search".localized, iconName: "Magnifier", tag: 1)
        return searchVc.addNavBarController(title: "StackOverFlow".localized)
    }()
    
    lazy var userController: UINavigationController = {
        let userVc = UserViewController()
        userVc.addTabBarItem(title: "User".localized, iconName: "Profile", tag: 2)
        return userVc.addNavBarController(title: "StackOverFlow".localized)
    }()
    
    lazy var answerController: AnswerViewController = {
        let answerVc = AnswerViewController()
        return answerVc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [homeController, searchController, userController]
        selectedViewController = homeController
        tabBar.barTintColor = Colors.AppTheme
    }

    func appLandingViewController() {
    }

}

extension ContainerViewController: ViewAnswerDelegate {
    
    func showAnswerForQuestion(at indexPath: Int, data: AnyObject) {
        homeController.pushViewController(answerController, animated: true)
    }
}

