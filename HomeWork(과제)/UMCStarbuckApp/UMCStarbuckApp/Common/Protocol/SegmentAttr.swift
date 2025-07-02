//
//  SegmentProtocol.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import Foundation
import SwiftUI

/// 세그먼트 컨트롤 항목이 공통적으로 가져야 할 속성을 정의한 프로토콜입니다.
/// 이 프로토콜을 채택한 열거형이나 타입은 세그먼트의 제목, 폰트 등의 UI 속성을 제공해야 합니다.
///
/// - `CaseIterable`: 모든 세그먼트 항목을 순회할 수 있게 함
/// - `Hashable`: 식별 및 비교를 위해 필요 (ForEach, Picker 등에서 사용 가능)
protocol SegmentAttr: CaseIterable, Hashable {
    
    /// 세그먼트에 표시할 텍스트 제목
    var segmentTitle: String { get }
    
    /// 세그먼트에 사용할 폰트 스타일
    var segmentFont: Font { get }
}
