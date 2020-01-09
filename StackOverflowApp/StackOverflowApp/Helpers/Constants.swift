//
//  Constants.swift
//  StackOverflowApp
//
//  Created by admin on 06/01/20.
//  Copyright © 2020 Gofrugal Technologies. All rights reserved.
//

import UIKit

struct Constants {
    
    static let CustomFont = "icomoon"
    
    struct FontSize {
        static let Regular: CGFloat = 15
        static let Medium: CGFloat = 18
        static let Large: CGFloat = 20
        static let Small: CGFloat = 12
        static let VerySmall: CGFloat = 10
    }
    
    struct Sizing {
        static let BorderWidth: CGFloat = 1
        static let QuestionCellHeight: CGFloat = 120
        static let StandardCornerRadius: CGFloat = 5
    }
    
    struct Urls {
        static let BaseUrl = "https://api.stackexchange.com"
    }
    
    struct UrlExtension {
        static let Questions = "/2.2/questions?order=desc&sort=%@&site=stackoverflow"
    }
    
    struct Numbers {
        static let TimeOutInterval: TimeInterval = 30
    }
    
    struct Items {
        static let AnswerCount = "answer_count"
        static let CreationDate = "creation_date"
        static let IsAnswered = "is_answered"
        static let LastActivityDate = "last_activity_date"
        static let Link = "link"
        static let Owner = "owner"
        static let QuestionId = "question_id"
        static let Score = "score"
        static let Tags = "tags"
        static let Title = "title"
        static let ViewCount = "view_count"
    }
    
    struct OwnerFields {
        static let DisplayName = "display_name"
        static let Link = "link"
        static let ProfileImage = "profile_image"
        static let Reputation = "reputation"
        static let UserId = "user_id"
        static let UserType = "user_type"
    }
    
    struct TimeValues {
        static let Minute = 60
        static let Hour = 60 * Minute
        static let Day = 24 * Hour
        static let Week = 7 * Day
        static let Month = 30 * Day
        static let Year = 365 * Day
    }
}
