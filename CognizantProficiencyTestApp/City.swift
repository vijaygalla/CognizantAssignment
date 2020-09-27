//
//  City.swift
//  CognizantProficiencyTestApp
//
//  Created by Vijay Bhaskar on 25/09/20.
//

import Foundation

public struct City: Codable {
    var title: String?
    var details: [CityDetail]?
    
    public init(title: String?, details: [CityDetail]?) {
        self.title = title
        self.details = details
    }
    public enum CodingKeys: String, CodingKey {
        case title
        case details = "rows"
    }
}

public struct CityDetail: Codable {
    var title: String?
    var descrption: String?
    var image: String?
    
    public init(title: String?, descrption: String?, image: String?) {
        self.title = title
        self.descrption = descrption
        self.image = image
    }
    
    public enum CodingKeys: String, CodingKey {
        case title
        case descrption = "description"
        case image = "imageHref"
    }
}
