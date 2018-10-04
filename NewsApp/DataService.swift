//
//  DataService.swift
//  NewsApp
//
//  Created by USER on 03/10/2018.
//  Copyright © 2018 My. All rights reserved.
//

import Foundation

class DataService {
    
    private init(){}
    
    static let shared = DataService()
  
    
    func getData(completion: @escaping ([[String: Any]]) -> Void) {
        
        guard let url = URL(string: "https://newsapi.org/v2/everything?sources=nhl-news&apiKey=afc4e5873cb0405ebaa4f4474ffb34f2") else {return}
        var getRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        getRequest.httpMethod = "GET"
        getRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        getRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: getRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil { print("GET Request: Communication error: \(error!)") }
            if data != nil {
                do {
                    let resultObject = try(JSONSerialization.jsonObject(with: data!, options: []))
                    let result = resultObject as! [String: Any]
                    var resultArticles = [[String: Any]]()
                    if (result["articles"] != nil) {
                        resultArticles = result["articles"] as! [[String: Any]]
                    }
                    DispatchQueue.main.async(execute: {
                    completion(resultArticles)
                    })
                } catch {
                    DispatchQueue.main.async(execute: {
                        print("Unable to parse JSON response")
                    })
                }
            } else {
                DispatchQueue.main.async(execute: {
                    print("Received empty response.")
                })
            }
        }).resume()
        
    }
    
    
    
}

