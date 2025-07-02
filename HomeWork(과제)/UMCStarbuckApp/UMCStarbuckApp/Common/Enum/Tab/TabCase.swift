//
//  TabCase.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation
import SwiftUI

/// 앱의 하단 탭바(Tab Bar)에 표시될 탭 항목들을 정의한 열거형입니다.
/// - `home`: 홈 화면
/// - `pay`: 결제(Pay) 화면
/// - `order`: 주문(Order) 화면
/// - `shop`: 매장 또는 쇼핑 관련 화면
/// - `other`: 기타 설정 또는 계정 관련 화면
///
/// `CaseIterable`을 채택하여 모든 탭 항목을 순회할 수 있으며,
/// 탭 아이콘은 프로젝트 내 `ImageResource`를 기반으로 설정됩니다.
enum TabCase: String, CaseIterable {
    
    /// 홈 탭
    case home = "Home"
    
    /// 결제 탭
    case pay = "Pay"
    
    /// 주문 탭
    case order = "Order"
    
    /// 매장/쇼핑 탭
    case shop = "Shop"
    
    /// 기타 탭 (설정, 계정 등)
    case other = "Other"
    
    /// 각 탭에 대응되는 아이콘 이미지를 반환합니다.
    /// 이미지 리소스는 `.home`, `.pay` 등 `ImageResource` 기반으로 지정되어 있어야 합니다.
    var icon: Image {
        switch self {
        case .home:
            return .init(.home)
        case .pay:
            return .init(.pay)
        case .order:
            return .init(.order)
        case .shop:
            return .init(.shop)
        case .other:
            return .init(.other)
        }
    }
}
