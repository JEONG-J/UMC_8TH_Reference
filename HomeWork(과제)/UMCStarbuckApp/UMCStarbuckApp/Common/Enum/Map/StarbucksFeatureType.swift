//
//  StarbucksFeatureType.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/25/25.
//

import Foundation

/// 스타벅스 매장 정보를 표현하는 GeoJSON 객체의 타입을 나타내는 열거형입니다.
/// - `feature`: 하나의 매장 또는 지리 데이터를 포함하는 Feature 객체
/// - `point`: Feature 내부에서 좌표 정보를 나타내는 Point 형식
///
/// 이 열거형은 GeoJSON 데이터를 디코딩할 때 사용되며,
/// 각 매장 위치와 속성을 포함하는 구조를 이해하고 파싱하는 데 도움이 됩니다.
enum StartbucksFeaturesType: String, Codable {
    
    /// GeoJSON의 Feature 객체 타입
    /// 매장의 속성(properties)과 지리 정보(geometry)를 포함하는 최상위 단위
    case feature = "Feature"
    
    /// GeoJSON의 Point 타입
    /// geometry 객체의 좌표 타입으로, 단일 위치를 의미
    case point = "Point"
}
