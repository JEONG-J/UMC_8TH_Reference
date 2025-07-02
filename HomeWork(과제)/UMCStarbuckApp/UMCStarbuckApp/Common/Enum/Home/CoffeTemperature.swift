//
//  CoffeTemperature.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/20/25.
//

import Foundation

/// 커피의 온도 종류를 나타내는 열거형입니다.
/// - `hot`: 따뜻한 커피 (HOT)
/// - `iced`: 차가운 커피 (ICED)
///
/// `String`을 원시값으로 사용하여 서버 통신 등에서 문자열로 쉽게 변환하거나 비교할 수 있습니다.
/// `CaseIterable`을 채택하여 모든 케이스를 배열처럼 순회할 수 있으며,
/// `Equatable`, `Hashable`을 채택하여 비교 및 Set, Dictionary 등에 사용 가능합니다.
enum CoffeeTemperature: String, CaseIterable, Equatable, Hashable {
    /// 따뜻한 커피
    case hot = "HOT"
    
    /// 차가운 커피
    case iced = "ICED"
}
