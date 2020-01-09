//
//  NetworkEngine.swift
//  StackOverflowApp
//
//  Created by Mohanasundaram on 10/01/20.
//  Copyright © 2020 AmsSanjeevi. All rights reserved.
//

import Foundation

class NetworkEngine {
    
    static let sharedInstance = NetworkEngine()
    
    func fetchQuestions(sortBy: String, page: Int, completion: @escaping Success) {
        let urlString = Constants.Urls.BaseUrl + String(format: Constants.UrlExtension.Questions, sortBy, page)
        SessionsManager.sharedInstance.GET(urlString: urlString, success: completion)
    }
}
