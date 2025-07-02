//
//  BrounSegmentStyle.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/27/25.
//

import Foundation
import SwiftUI

/// 커스텀 세그먼트에 적용할 브라운 테마 스타일입니다.
/// `CustomSegmentStyle` 프로토콜을 채택하여 외부에서 일관된 스타일을 주입할 수 있도록 구성됩니다.
struct BrownSegmentStyle: CustomSegmentStyle {
    
    /// 캡슐(선택 표시 바)의 수직 위치 오프셋
    var capsuleOffset: CGFloat = .zero
    
    /// 세그먼트 전체 배경 뷰 표시 여부
    var showSegmentBackground: Bool = false
    
    /// 선택된 세그먼트 밑줄 또는 캡슐 색상
    var segmentColor: Color = Color.brown02
    
    /// 세그먼트 항목 간의 수평 간격
    var segmentHSpacing: CGFloat = 140
    
    /// 세그먼트 항목 내부에서 텍스트와 캡슐 간 수직 간격
    var segmentVSpacing: CGFloat = 5
    
    /// 선택 캡슐의 높이
    var segmentHeight: CGFloat = 5
    
    /// 캡슐 너비 모드: 텍스트 길이에 맞추거나 전체 폭으로 설정 가능
    var segmentWidthMode: CapsuleWidthMode = .textWidth
    
    /// 각 세그먼트 항목에 적용할 좌우 패딩을 반환
    /// - `segment`: 현재 항목
    /// - `isFirst`: 첫 번째 항목 여부 (필요 시 별도 패딩 적용 가능)
    func horizontalPadding(segment: any SegmentAttr, isFirst: Bool = false) -> (CGFloat, CGFloat) {
        return (.zero, .zero)
    }
}
