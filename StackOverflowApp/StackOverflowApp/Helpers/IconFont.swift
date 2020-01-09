//
//  IconFont.swift
//  StackOverflowApp
//
//  Created by admin on 06/01/20.
//  Copyright © 2020 Gofrugal Technologies. All rights reserved.
//

import UIKit

class IconFont: UIFont {
    
    enum IconName: Int {
        case FeedIcon = 0
        case UserIcon
        case DropDownIcon
    }
    
    static let sharedInstance = IconFont()
    
    private lazy var iconDictionary = [
        IconName.FeedIcon : "\u{e91a}",
        IconName.UserIcon : "\u{e91b}",
        IconName.DropDownIcon: "\u{e91c}"
    ]
    
    func getIconFont(name: IconName) -> String {
        return iconDictionary[name] ?? ""
    }
}
