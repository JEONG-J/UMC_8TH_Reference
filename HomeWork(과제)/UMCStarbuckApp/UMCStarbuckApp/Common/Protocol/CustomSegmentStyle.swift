//
//  CustomSegmentStyle.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/27/25.
//

import Foundation
import SwiftUI

/// 커스텀 세그먼트 컴포넌트의 스타일을 정의하기 위한 프로토콜입니다.
/// 각 세그먼트의 레이아웃, 색상, 패딩 등을 커스터마이징할 수 있습니다.
protocol CustomSegmentStyle {
    
    /// 선택된 세그먼트를 감싸는 캡슐(또는 하이라이트)의 가로 오프셋입니다.
    var capsuleOffset: CGFloat { get }
    
    /// 세그먼트 배경을 표시할지 여부를 결정합니다.
    var showSegmentBackground: Bool { get }
    
    /// 세그먼트 간의 가로 간격입니다.
    var segmentHSpacing: CGFloat { get }
    
    /// 세그먼트 간의 세로 간격입니다.
    var segmentVSpacing: CGFloat { get }
    
    /// 각 세그먼트의 고정 높이입니다.
    var segmentHeight: CGFloat { get }
    
    /// 세그먼트의 너비 설정 방식 (예: 고정, 콘텐츠 크기에 맞춤 등)
    var segmentWidthMode: CapsuleWidthMode { get }
    
    /// 세그먼트의 기본 색상입니다.
    var segmentColor: Color { get }

    /// 세그먼트 항목별 좌우 패딩을 반환합니다.
    /// - Parameters:
    ///   - segment: 현재 세그먼트 항목
    ///   - isFirst: 첫 번째 항목 여부
    /// - Returns: 좌우 패딩 값 (leading, trailing)
    func horizontalPadding(segment: any SegmentAttr, isFirst: Bool) -> (CGFloat, CGFloat)
}
