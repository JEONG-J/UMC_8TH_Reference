//
//  StoreSearchType.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/25/25.
//

import Foundation

/// 매장 검색 시 사용할 필터 타입을 나타내는 열거형입니다.
/// - `nearStore`: 현재 위치 기준으로 가까운 매장 목록
/// - `favoriteStore`: 사용자가 자주 방문하는 즐겨찾기 매장 목록
///
/// `CaseIterable`을 채택하여 모든 검색 타입을 배열처럼 순회할 수 있으며,
/// `Identifiable`을 채택하여 SwiftUI의 리스트나 Picker 등에서 직접 사용할 수 있습니다.
enum StoreSearchType: String, CaseIterable, Identifiable {
    
    /// 가까운 매장
    case nearStore = "가까운 매장"
    
    /// 자주 가는 매장
    case favoriteStore = "자주가는 매장"
    
    /// `Identifiable` 프로토콜을 위한 고유 ID
    /// 각 케이스의 `rawValue`를 그대로 사용합니다.
    var id: String { self.rawValue }
}
