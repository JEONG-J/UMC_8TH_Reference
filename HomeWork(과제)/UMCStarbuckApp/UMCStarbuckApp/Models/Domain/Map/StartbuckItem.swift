//
//  StoreItem.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/25/25.
//

import Foundation

/// 스타벅스 데이터 조회
struct StarbucksItem: Codable, Identifiable {
    var id: UUID = .init()
    let type: String
    let name: String
    let features: [Feature]
    
    enum CodingKeys: CodingKey {
        case type
        case name
        case features
    }
}

struct Feature: Codable, Identifiable {
    var id: String { properties.seq }
    let type: StartbucksFeaturesType
    var properties: Propertie
    let geometry: GeometryInfo
    
    enum CodingKeys: CodingKey {
        case type
        case properties
        case geometry
    }
}

struct Propertie: Codable {
    let seq: String
    let storeName: String
    var address: String
    let telephone: String
    let category: StartbucksCategory?
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case seq = "Seq"
        case storeName = "Sotre_nm"
        case address = "Address"
        case telephone = "Telephone"
        case category = "Category"
        case latitude = "Ycoordinate"
        case longitude = "Xcoordinate"
    }
}

struct GeometryInfo: Codable {
    let type: StartbucksFeaturesType
    let coordinates: [Double]
}
