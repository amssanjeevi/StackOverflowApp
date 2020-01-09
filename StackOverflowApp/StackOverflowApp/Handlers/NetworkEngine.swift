//
//  NetworkEngine.swift
//  StackOverflowApp
//
//  Created by admin on 08/01/20.
//  Copyright © 2020 Gofrugal Technologies. All rights reserved.
//

import Foundation

class NetworkEngine {
    
    static let sharedInstance = NetworkEngine()
    
    func fetchQuestions(sortBy: String, completion: @escaping Success) {
        let urlString = Constants.Urls.BaseUrl + String(format: Constants.UrlExtension.Questions, sortBy)
        SessionsManager.sharedInstance.GET(urlString: urlString, success: completion)
    }
}
