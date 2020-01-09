//
//  TextView+Theme.swift
//  StackOverflowApp
//
//  Created by admin on 08/01/20.
//  Copyright © 2020 Gofrugal Technologies. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyCornerRadius(of radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func addBorder(borderColor: UIColor) {
        layer.borderWidth = Constants.Sizing.BorderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
    }
    
    func applyBackgroundBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
