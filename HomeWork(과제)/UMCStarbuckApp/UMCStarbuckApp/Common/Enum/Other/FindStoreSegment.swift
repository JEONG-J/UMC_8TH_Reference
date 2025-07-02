//
//  FindStoreSegment.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/27/25.
//

import Foundation
import SwiftUI

/// '매장 찾기' 화면에서 사용하는 세그먼트 항목 열거형입니다.
/// - `findStore`: 지도 또는 리스트를 통해 매장을 찾는 모드
/// - `findeRoad`: 특정 매장까지 길찾기를 수행하는 모드
///
/// `SegmentAttr` 프로토콜을 채택하여 세그먼트 제목과 폰트 스타일을 제공하며,
/// SwiftUI의 `SegmentedControl`이나 커스텀 탭 UI에 활용됩니다.
enum FindStoreSegment: String, SegmentAttr {
    
    /// 매장 찾기 모드
    case findStore = "매장 찾기"
    
    /// 길찾기 모드
    case findeRoad = "길찾기"
    
    /// 세그먼트에 표시될 텍스트 제목
    var segmentTitle: String {
        return self.rawValue
    }
    
    /// 세그먼트에 적용할 폰트 스타일
    /// 커스텀 폰트 `.mainTextSemiBold24`를 사용
    var segmentFont: Font {
        return .mainTextSemiBold24
    }
}
