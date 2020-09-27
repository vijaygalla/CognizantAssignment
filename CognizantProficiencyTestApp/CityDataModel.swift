//
//  CityDataModel.swift
//  CognizantProficiencyTestApp
//
//  Created by Vijay Bhaskar on 25/09/20.
//

import Foundation

class CityDataModel {
    var city: City?
    
    func getCityData(url: String, parameters: [String: String], completion:@escaping(_ error: Error?)->()) {
        
        NetworkManager.getDataAPI(url: url, parameters: parameters) { (responseData,error)  in
            
            if error == nil {
                do {
                    if let data = responseData {
                            let cityObj = try JSONDecoder().decode(City.self, from: data)
                            self.city = cityObj
                    }
    
                    completion(nil)
                } catch {
                    fatalError("Failed to decode the data")
                }
            } else {
                completion(error)
            }
        }
    }
}