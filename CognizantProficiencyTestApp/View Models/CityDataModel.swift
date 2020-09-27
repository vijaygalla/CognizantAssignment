//
//  CityDataModel.swift
//  CognizantProficiencyTestApp
//
//  Created by Vijay Bhaskar on 25/09/20.
//

import Foundation

protocol CityDataModelDelegate {
    func getCityData(url: String, parameters: [String: String], completion:@escaping(_ error: Error?)->())
}

class CityDataModel: CityDataModelDelegate {
    var city: City?
    
    func getCityData(url: String, parameters: [String: String], completion:@escaping(_ error: Error?)->()) {
        
        NetworkManager.getDataAPI(url: url, parameters: parameters) { (result)  in
            
            switch result {
            case .success(let data):
                do {
                    let cityObj = try JSONDecoder().decode(City.self, from: data)
                    self.city = cityObj
                    completion(nil)
                } catch {
                    fatalError("Failed to decode the data")
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
}
