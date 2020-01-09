//
//  TextView+Theme.swift
//  StackOverflowApp
//
//  Created by admin on 08/01/20.
//  Copyright © 2020 Gofrugal Technologies. All rights reserved.
//

import UIKit

extension UITextView {
    
    func addStandardTextTheme() {
        font = UIFont.systemFont(ofSize: Constants.FontSize.Regular, weight: .semibold)
        textColor = Colors.AppTheme
    }
}
