//
//  NetworkManager.swift
//  CognizantProficiencyTestApp
//
//  Created by Vijay Bhaskar on 25/09/20.
//

import UIKit
import Foundation


class NetworkManager {
    
    class func getDataAPI(url: String, parameters: [String: String], completion: @escaping(Result<Data, Error>)->Void){

        guard let url = URL(string: url) else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = NetworkConstants.httpGet
        urlRequest.httpBody = nil
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil, let data = data {
                let jsonString = String(data: data, encoding: .isoLatin1)
                if let jsonData = jsonString?.data(using: .utf8) {
                    completion(.success(jsonData))
                }
            } else {
                    completion(.failure(error!))
                }
        }.resume()
    }
}
