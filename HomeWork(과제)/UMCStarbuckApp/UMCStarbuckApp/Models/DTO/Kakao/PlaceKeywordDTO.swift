//
//  PlaceKeywordDTO.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/2/25.
//

import Foundation

// MARK: - KakaoPlaceResponse
struct KakaoPlaceResponse: Codable {
    let documents: [KakaoPlaceDocument]
    let meta: KakaoPlaceMeta
}

// MARK: - Document
struct KakaoPlaceDocument: Codable, Identifiable {
    var id: String                 
    let addressName: String
    let categoryGroupCode: String?
    let categoryGroupName: String?
    let categoryName: String
    let distance: String?
    let phone: String
    let placeName: String
    let placeURL: String
    let roadAddressName: String
    let x: String                   
    let y: String

    enum CodingKeys: String, CodingKey {
        case id
        case addressName = "address_name"
        case categoryGroupCode = "category_group_code"
        case categoryGroupName = "category_group_name"
        case categoryName = "category_name"
        case distance
        case phone
        case placeName = "place_name"
        case placeURL = "place_url"
        case roadAddressName = "road_address_name"
        case x
        case y
    }
}

// MARK: - Meta
struct KakaoPlaceMeta: Codable {
    let isEnd: Bool
    let pageableCount: Int
    let sameName: KakaoPlaceSameName
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case sameName = "same_name"
        case totalCount = "total_count"
    }
}

// MARK: - SameName
struct KakaoPlaceSameName: Codable {
    let keyword: String
    let region: [String]
    let selectedRegion: String

    enum CodingKeys: String, CodingKey {
        case keyword
        case region
        case selectedRegion = "selected_region"
    }
}
