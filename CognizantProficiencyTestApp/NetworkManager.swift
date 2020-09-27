//
//  NetworkManager.swift
//  CognizantProficiencyTestApp
//
//  Created by OMNIADMIN on 25/09/20.
//

import UIKit
import Foundation


class NetworkManager {
    
    class func getDataAPI(url: String, parameters: [String: String], completion: @escaping(_ data: Data?, _ error: Error?)->Void){

        guard let url = URL(string: url) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.httpBody = nil
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil, let data = data {
                let jsonString = String(data: data, encoding: .isoLatin1)
                if let jsonData = jsonString?.data(using: .utf8) {
                    completion(jsonData, nil)
                }
            } else {
                completion(nil, error)
                }
        }.resume()
    }
}
