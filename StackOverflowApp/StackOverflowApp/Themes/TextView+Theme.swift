//
//  TextView+Theme.swift
//  StackOverflowApp
//
//  Created by Mohanasundaram on 10/01/20.
//  Copyright © 2020 AmsSanjeevi. All rights reserved.
//

import UIKit

extension UITextView {
    
    func addStandardTextTheme() {
        font = UIFont.systemFont(ofSize: Constants.FontSize.Regular, weight: .semibold)
        textColor = Colors.AppTheme
    }
}
