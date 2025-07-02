//
//  OtherMenuButton.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import Foundation
import SwiftUI

/// '기타' 탭에서 표시될 메뉴 버튼 항목을 정의하는 프로토콜입니다.
/// 열거형(enum) 기반으로 정의되며, 각 버튼은 아이콘과 타이틀을 가져야 합니다.
///
/// 이 프로토콜을 채택하면 SwiftUI에서 `ForEach`를 통해 반복 렌더링하거나,
/// 고유 식별자로 버튼을 구분하는 등의 작업이 가능합니다.
protocol OtherMenuButton: Identifiable, CaseIterable, RawRepresentable where RawValue == String {
    
    /// 버튼에 표시될 아이콘 이미지
    /// SwiftGen 등에서 생성된 `ImageResource` 타입을 사용
    var icon: ImageResource { get }
    
    /// 버튼에 표시될 텍스트 제목
    var title: String { get }
}
