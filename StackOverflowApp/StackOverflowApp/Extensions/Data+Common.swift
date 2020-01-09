//
//  Data+Common.swift
//  StackOverflowApp
//
//  Created by Mohanasundaram on 10/01/20.
//  Copyright © 2020 AmsSanjeevi. All rights reserved.
//

import Foundation

extension Data {
    
    var json: AnyObject {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: []) else { return [:] as AnyObject }
        return json as AnyObject
    }
}
