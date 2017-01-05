//
//  NetworkHelper.swift
//  CarFinder
//
//  Created by Adriana Elizondo on 04/01/2017.
//  Copyright © 2017 Adriana. All rights reserved.
//

import Foundation
import UIKit

public let baseUrl = "http://www.codetalk.de/"

public typealias RequestResponse = (Bool, Any?, Error?) -> Void

class NetworkHelper{
    static func getDataWithUrl(stringUrl: String, completion: @escaping RequestResponse){
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        guard let url = URL.init(string: baseUrl + stringUrl) else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            return
        }
        
        requestWith(url: URLRequest.init(url: url), completion: completion)
    }
    
    static func requestWith(url: URLRequest, completion: @escaping RequestResponse){
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                let decodedResponse = try? JSONSerialization.jsonObject(with: data, options: [])
                if let code = (response as? HTTPURLResponse)?.statusCode , 200...299 ~= code{
                    completion(true, decodedResponse, nil)
                }else{
                    completion(false, nil, error)
                }
            }else{
                completion(false, nil, error)
            }
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            }.resume()
    }
    
}
