//
//  Data+Common.swift
//  StackOverflowApp
//
//  Created by admin on 08/01/20.
//  Copyright © 2020 Gofrugal Technologies. All rights reserved.
//

import Foundation

extension Data {
    
    var json: AnyObject {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: []) else { return [:] as AnyObject }
        return json as AnyObject
    }
}
