//
//  RoutePosition.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/29/25.
//

import Foundation
import SwiftUI

/// 경로 탐색에서 사용되는 위치 입력 타입을 나타내는 열거형입니다.
/// - `departure`: 출발지 입력 필드를 의미
/// - `arrival`: 도착지(매장 또는 주소) 입력 필드를 의미
///
/// 입력 필드에 따라 플레이스홀더 문구를 다르게 표시하고,
/// 출발지 입력일 경우 '현재 위치' 버튼을 활성화하는 등의 UI 로직에 활용됩니다.
enum RoutePosition: String, CaseIterable {
    
    /// 출발지 입력
    case departure = "출발"
    
    /// 도착지 입력 (매장명 또는 주소)
    case arrival = "도착"
    
    /// 각 위치 입력에 맞는 플레이스홀더 문구를 반환합니다.
    /// - 출발지: "출발지 입력"
    /// - 도착지: "매장명 또는 주소"
    var placeholder: String {
        switch self {
        case .departure:
            return "출발지 입력"
        case .arrival:
            return "매장명 또는 주소"
        }
    }
    
    /// 출발지 입력일 때만 `true`를 반환합니다.
    /// 주로 '현재 위치' 버튼 표시 여부에 사용됩니다.
    var isCurrentButton: Bool {
        return self == .departure
    }
    
    /// 검색필드에 따른 Alert 메시지 값
    var alertMessage: String {
        switch self {
        case .departure:
            return "검색 결과가 존재하지 않습니다."
        case .arrival:
            return "해당 검색어로 조회된 매장정보가 존재하지 않아요!"
        }
    }
}
