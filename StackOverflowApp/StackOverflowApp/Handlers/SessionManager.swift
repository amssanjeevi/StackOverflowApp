//
//  SessionManager.swift
//  StackOverflowApp
//
//  Created by Mohanasundaram on 10/01/20.
//  Copyright © 2020 AmsSanjeevi. All rights reserved.
//

import Foundation

public typealias ResponseHandler = (_ data: Any?, _ response: Any?, _ error: Error?) -> Void
public typealias Success = (_ response: Any?) -> Void
public typealias Failure = (_ error: Error?) -> Void

class SessionsManager {
    
    static let sharedInstance = SessionsManager()
    var defaultHTTPHeader: [String: String] = [:]
    
    init() {
        
    }
    
    func GET(urlString: String, success: Success?, failure: Failure? = nil, isJSON: Bool = true) {
        dataTask(httpMethod: "GET", urlString: urlString, body: nil, responseHandler: { (data, response, error) in
            self.verifyAndExtractData(data: data, response: response, error: error, completion: { (data) in
                success!(data)
            })
        }, isJSON: isJSON)
    }
    
    func PUT(urlString: String, success: Success?, failure: Failure? = nil, isJSON: Bool = true) {
        dataTask(httpMethod: "PUT", urlString: urlString, body: nil, responseHandler: { (data, response, error) in
            print(data as Any, error as Any)
        }, isJSON: isJSON)
    }
    
    func POST(urlString: String, success: Success?, failure: Failure? = nil, isJSON: Bool = true) {
        dataTask(httpMethod: "POST", urlString: urlString, body: nil, responseHandler: { (data, response, error) in
            print(data as Any, error as Any)
        }, isJSON: isJSON)
    }
    
    private func dataTask(httpMethod: String, urlString: String, body: [String: String]?, responseHandler: @escaping ResponseHandler, isJSON: Bool) {
        let request = getUrlRequest(url: URL(string: urlString)!)
        request.httpMethod = httpMethod
        request.setHTTPRequestBody(from: body, isJSON: isJSON)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async { responseHandler(data, response, error) }
        }.resume()
    }
}

extension SessionsManager {
    
    func getUrlRequest(url: URL) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url)
        request.timeoutInterval = Constants.Numbers.TimeOutInterval
        request.setHTTPHeaderFields(from: defaultHTTPHeader)
        return request
    }
    
    private func verifyAndExtractData(data: Any?, response: Any?, error: Error?, completion: Success?) {
        guard error == nil else {
            Notifier.sharedInstance.showAlert(alertTitle: "Error".localized, message: error?.localizedDescription ?? "", firstButtonTitle: "Okay".localized)
            return
        }
        guard let response = response as? HTTPURLResponse else {
            Notifier.sharedInstance.showAlert(alertTitle: "Empty Response", message: "Invalid or Empty Response from the Server", firstButtonTitle: "Okay".localized)
            return
        }
        guard let data = data as? Data else {
            Notifier.sharedInstance.showAlert(alertTitle: "Invalid Data", message: "Invalid or Empty Data from the Server", firstButtonTitle: "Okay".localized)
            return
        }
        let serialisedData = data.json
        guard (200...299) ~= response.statusCode else {
            let errorMessage = serialisedData.value(forKey: "error_message") as? String ?? ""
            let errorName = serialisedData.value(forKey: "error_name") as? String ?? ""
            Notifier.sharedInstance.showAlert(alertTitle: "Bad Response Code", message: errorName + errorMessage, firstButtonTitle: "Okay".localized)
            return
        }
        completion!(serialisedData)
    }
}

extension NSMutableURLRequest {
    
    func setHTTPHeaderFields(from dictionary: [String: String]) {
        for (HTTPHeaderField, value) in dictionary {
            setValue(value, forHTTPHeaderField: HTTPHeaderField)
        }
    }
    
    func setHTTPRequestBody(from body: [String: String]?, isJSON: Bool) {
        guard let body = body, !body.isEmpty else { return }
        do {
            if (!isJSON){
                let body = body.map { "\($0)=\($1)"}.joined(separator: "&")
                httpBody = body.data(using: String.Encoding.utf8)
                setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            }else{
                httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            print(error)
        }
    }
}

