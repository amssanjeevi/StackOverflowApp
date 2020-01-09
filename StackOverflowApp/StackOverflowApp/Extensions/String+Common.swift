//
//  String+Common.swift
//  StackOverflowApp
//
//  Created by Mohanasundaram on 10/01/20.
//  Copyright © 2020 AmsSanjeevi. All rights reserved.
//

import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var percentEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    var timeAgo: String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(self) ?? 0)
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        let monthAgo = calendar.date(byAdding: .day, value: -30, to: Date())!
        let yearAgo = calendar.date(byAdding: .day, value: -365, to: Date())!
        
        if minuteAgo < date {
            let diff = Calendar.current.dateComponents([.second], from: date, to: Date()).second ?? 0
            return "\(diff) sec ago"
        } else if hourAgo < date {
            let diff = Calendar.current.dateComponents([.minute], from: date, to: Date()).minute ?? 0
            return "\(diff) min ago"
        } else if dayAgo < date {
            let diff = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour ?? 0
            return "\(diff) hrs ago"
        } else if weekAgo < date {
            let diff = Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
            return "\(diff) days ago"
        } else if monthAgo < date {
            let diff = Calendar.current.dateComponents([.weekOfYear], from: date, to: Date()).weekOfYear ?? 0
            return "\(diff) weeks ago"
        } else if yearAgo < date {
            let diff = Calendar.current.dateComponents([.month], from: date, to: Date()).month ?? 0
            return "\(diff) Months ago"
        }
        let diff = Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0
        return "\(diff) years ago"
    }
    
    func getIconWithTitle(iconName: IconFont.IconName) -> String  {
        return "Title"
//        return getAttributedText(
//                firstString: IconFont.sharedInstance.getIconFont(name: iconName),
//                firstFont: UIFont(name: Constants.CustomFont, size: Constants.FontSize.Regular)!,
//                firstColor: Colors.AppTheme,
//                secondString: self,
//                secondFont: UIFont.systemFont(ofSize: Constants.FontSize.Regular, weight: .semibold),
//                secondColor: Colors.AppTheme
//        )
    }
}
