//
//  CognizantProficiencyTestAppTests.swift
//  CognizantProficiencyTestAppTests
//
//  Created by OMNIADMIN on 27/09/20.
//

import XCTest

@testable import CognizantProficiencyTestApp

var city: City {
    let cityDetail = CityDetail(title: "Sample title", descrption: "Sample description", image: nil)
    let city = City(title:"About City" , details: [cityDetail])
    return city
}

class CognizantProficiencyTestAppTests: XCTestCase {
    
    func testAPIWithStubData() {
        var cityDetail: City?
        let apiModel = StubDataWithAPI()
        apiModel.getCityData(url: NetworkConstants.cityAPIUrl, parameters: [:]) { (error) in
          cityDetail = city
        }
        XCTAssertEqual(cityDetail, city)
    }
}

private class StubDataWithAPI: CityDataModelDelegate {
    func getCityData(url: String, parameters: [String : String], completion: @escaping (Error?) -> ()) {
        
        completion(nil)
    }
}
