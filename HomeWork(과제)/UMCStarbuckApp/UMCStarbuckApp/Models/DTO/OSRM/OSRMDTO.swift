//
//  OSRMDTO.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/2/25.
//

import Foundation

// MARK: - Request
struct OSRMRouteRequset: Codable {
    /// 출발지
    var startPoint: Coordinate
    
    /* 실제 앱 사용시에는 경유지 포인트도 있어야 합니다! */
    
    /// 도착지
    var endPoint: Coordinate
}

// MARK: - Response
struct OSRMRouteResponse: Codable {
    let code: String
    let routes: [OSRMRoute]
    let waypoints: [OSRMWaypoint]
}

struct OSRMRoute: Codable {
    let geometry: GeometryValue
    let legs: [RouteLeg]
    let weightName: String
    let weight: Double
    let duration: Double
    let distance: Double

    enum CodingKeys: String, CodingKey {
        case geometry, legs
        case weightName = "weight_name"
        case weight, duration, distance
    }
}

struct GeometryValue: Codable {
    let coordinates: [[Double]] // [longitude, latitude]
    let type: String
}

struct RouteLeg: Codable {
    let steps: [String] // 빈 배열이므로 생략 가능
    let summary: String
    let weight: Double
    let duration: Double
    let distance: Double
}

struct OSRMWaypoint: Codable {
    let hint: String
    let distance: Double
    let name: String
    let location: [Double]
}
