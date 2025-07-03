//
//  PlaceDTO.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/2/25.
//

import Foundation
import CoreLocation

// MARK: - Root Response
struct PlaceResponse: Codable {
    let htmlAttributions: [String]
    let results: [Place]
    let status: String

    enum CodingKeys: String, CodingKey {
        case htmlAttributions = "html_attributions"
        case results
        case status
    }
}

// MARK: - Place
struct Place: Codable {
    let businessStatus: String
    let formattedAddress: String
    let geometry: Geometry
    let icon: String
    let iconBackgroundColor: String
    let iconMaskBaseURI: String
    let name: String
    let openingHours: OpeningHours?
    let photos: [Photo]?
    let placeID: String
    let plusCode: PlusCode
    let rating: Double
    let reference: String
    let types: [String]
    let userRatingsTotal: Int

    enum CodingKeys: String, CodingKey {
        case businessStatus = "business_status"
        case formattedAddress = "formatted_address"
        case geometry
        case icon
        case iconBackgroundColor = "icon_background_color"
        case iconMaskBaseURI = "icon_mask_base_uri"
        case name
        case openingHours = "opening_hours"
        case photos
        case placeID = "place_id"
        case plusCode = "plus_code"
        case rating
        case reference
        case types
        case userRatingsTotal = "user_ratings_total"
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let location: Coordinate
    let viewport: Viewport
}

// MARK: - Viewport
struct Viewport: Codable {
    let northeast: Coordinate
    let southwest: Coordinate
}

// MARK: - OpeningHours
struct OpeningHours: Codable {
    let openNow: Bool

    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
    }
}

// MARK: - Photo
struct Photo: Codable {
    let height: Int
    let htmlAttributions: [String]
    let photoReference: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case height
        case htmlAttributions = "html_attributions"
        case photoReference = "photo_reference"
        case width
    }
}

// MARK: - PlusCode
struct PlusCode: Codable {
    let compoundCode: String
    let globalCode: String

    enum CodingKeys: String, CodingKey {
        case compoundCode = "compound_code"
        case globalCode = "global_code"
    }
}
