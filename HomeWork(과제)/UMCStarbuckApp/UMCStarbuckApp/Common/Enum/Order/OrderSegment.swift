//
//  OrderSegment.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import Foundation
import SwiftUI

/// 주문 화면에서 사용할 세그먼트 항목을 정의한 열거형입니다.
/// - `allMenu`: 전체 메뉴 보기
/// - `myMenu`: 사용자 맞춤 메뉴 (나만의 메뉴)
/// - `cakeMenu`: 홀케이크 예약 메뉴
///
/// `SegmentAttr` 프로토콜을 채택하여 각 항목의 제목(`segmentTitle`)과
/// 스타일(`segmentFont`)을 세그먼트 UI에서 통일되게 사용할 수 있습니다.
enum OrderSegment: String, SegmentAttr {
    
    /// 전체 메뉴 보기
    case allMenu = "전체 메뉴"
    
    /// 나만의 메뉴 (즐겨찾기나 사용자 설정 메뉴)
    case myMenu = "나만의 메뉴"
    
    /// 홀케이크 예약 메뉴
    case cakeMenu = "홀케이크 예약"
    
    /// 세그먼트에 표시될 텍스트를 반환합니다.
    /// `rawValue`를 그대로 사용하여 한글 문자열 출력
    var segmentTitle: String {
        self.rawValue
    }
    
    /// 세그먼트에 적용할 폰트 스타일을 반환합니다.
    /// 앱에서 정의한 `.mainTextBold16` 커스텀 폰트를 사용
    var segmentFont: Font {
        return .mainTextBold16
    }
}
