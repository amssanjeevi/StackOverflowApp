//
//  Constraints.swift
//  StackOverflowApp
//
//  Created by Mohanasundaram on 10/01/20.
//  Copyright © 2020 AmsSanjeevi. All rights reserved.
//

import SnapKit

extension UIView {
    
    func spinnerConstraints(spinner: UIView, label: UIView) {
        spinner.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(snp.top).offset(30)
        }
        label.snp.makeConstraints { (make) in
            make.width.equalTo(snp.width)
            make.height.equalTo(30)
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(spinner.snp.bottom).offset(20)
        }
    }
    
    func spinnerBackGroundConstraints(background: UIView) {
        background.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
        }
    }
}

