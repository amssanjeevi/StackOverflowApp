//
//  Label+Theme.swift
//  StackOverflowApp
//
//  Created by admin on 08/01/20.
//  Copyright © 2020 Gofrugal Technologies. All rights reserved.
//

import UIKit

extension UILabel {
    
    func addLineBreak(lineCount: Int, mode: NSLineBreakMode = .byWordWrapping) {
        lineBreakMode = mode
        numberOfLines = lineCount
    }
    
    func addStandardTextTheme() {
        font = UIFont.systemFont(ofSize: Constants.FontSize.Small, weight: .light)
        textColor = Colors.LightTextColor
    }
    
    func applyRegularTextTheme() {
        font = UIFont.systemFont(ofSize: Constants.FontSize.Regular, weight: .regular)
        textColor = Colors.LightTextColor
    }
    
    func applyVerySmallTextTheme() {
        font = UIFont.systemFont(ofSize: Constants.FontSize.VerySmall, weight: .regular)
        textColor = Colors.LightTextColor
    }
    
    func applyVerySmallTextPrimaryTheme() {
        font = UIFont.systemFont(ofSize: Constants.FontSize.VerySmall, weight: .regular)
        textColor = Colors.PrimaryBlue
    }
    
    func applyRegularTextPrimaryTheme() {
        font = UIFont.systemFont(ofSize: Constants.FontSize.Regular, weight: .regular)
        textColor = Colors.PrimaryBlue
    }
    
    func attributedText(firstText: String, firstTextFont: (CGFloat, UIFont.Weight), firstTextColor: UIColor, secondText: String, secondTextFont: (CGFloat, UIFont.Weight), secondTextColor: UIColor) {
        let firstTextRange = NSMakeRange(0, firstText.count)
        let secondTextRange = NSMakeRange(firstText.count, secondText.count)
        let attributedString = NSMutableAttributedString(string: firstText + secondText)
        let firstFont = UIFont.systemFont(ofSize: firstTextFont.0, weight: firstTextFont.1)
        let secondFont = UIFont.systemFont(ofSize: secondTextFont.0, weight: secondTextFont.1)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: firstTextColor, range: firstTextRange)
        attributedString.addAttribute(NSAttributedString.Key.font, value: firstFont, range: firstTextRange)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: secondTextColor, range: secondTextRange)
        attributedString.addAttribute(NSAttributedString.Key.font, value: secondFont, range: secondTextRange)
        attributedString.addAttribute(NSAttributedString.Key.baselineOffset, value: ((firstFont.pointSize - secondFont.pointSize)/2), range: secondTextRange)
        attributedText = attributedString
    }
}
