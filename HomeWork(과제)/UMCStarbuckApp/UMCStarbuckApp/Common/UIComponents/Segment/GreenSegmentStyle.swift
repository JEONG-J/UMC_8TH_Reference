//
//  GreenSegmentStyle.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/27/25.
//

import Foundation
import SwiftUI

/// 초록색 테마를 적용한 커스텀 세그먼트 스타일입니다.
/// `CustomSegment`에 주입하여 선택 바, 간격, 패딩 등 외형을 조절할 수 있습니다.
struct GreenSegmentStyle: CustomSegmentStyle {
    
    /// 선택 캡슐(밑줄)의 수직 오프셋
    /// 값이 클수록 아래로 이동
    var capsuleOffset: CGFloat = 3
    
    /// 세그먼트 전체 배경 뷰 표시 여부
    var showSegmentBackground: Bool = true
    
    /// 선택된 세그먼트를 표시할 색상 (하단 캡슐 색상)
    var segmentColor: Color = Color.green01
    
    /// 세그먼트 항목 간 수평 간격
    /// `0`일 경우 개별 패딩으로 정렬 제어
    var segmentHSpacing: CGFloat = .zero
    
    /// 세그먼트 내부 텍스트와 캡슐 간의 수직 간격
    var segmentVSpacing: CGFloat = .zero
    
    /// 선택된 세그먼트 하단 캡슐의 높이
    var segmentHeight: CGFloat = 3
    
    /// 캡슐 너비 모드: `.fullWidth`로 설정되어 전체 영역을 차지하도록 지정
    var segmentWidthMode: CapsuleWidthMode = .fullWidth
    
    /// 세그먼트 항목별 좌우 패딩을 반환합니다.
    /// - `segment`: 현재 세그먼트 항목
    /// - `isFirst`: 첫 번째 항목 여부 (첫 항목일 경우 별도 패딩 적용)
    func horizontalPadding(segment: any SegmentAttr, isFirst: Bool) -> (CGFloat, CGFloat) {
        // `OrderSegment` 타입일 경우 케이스별로 다르게 설정
        if let segment = segment as? OrderSegment {
            switch segment {
            case .cakeMenu:
                // 홀케이크 예약 버튼은 여백이 더 큼
                return (50, 27)
            default:
                // 첫 항목은 좌우 여백 30, 그 외는 23
                return isFirst ? (30, 30) : (23, 23)
            }
        } else {
            // 그 외 세그먼트 타입은 기본값
            return (0, 0)
        }
    }
}
