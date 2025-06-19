//
//  topTitleEnum.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/18/25.
//

import Foundation
import SwiftUI

/// 로그인 화면 상단에 표시될 타이틀 및 서브타이틀을 정의하는 열거형
/// 각 케이스는 텍스트와 그에 해당하는 폰트 스타일 및 색상을 함께 제공
enum LoginTitleText: String, CaseIterable {
    
    /// 메인 타이틀 (굵은 폰트, 두 줄로 구성)
    case title = "안녕하세요. \n스타벅스입니다."
    
    /// 서브 타이틀 (로그인 안내 문구)
    case subTitle = "회원 서비스 이용을 위해 로그인을 해주세요"
    
    /// 각 텍스트에 적용할 폰트 스타일
    var font: Font {
        switch self {
        case .title:
            return Font.mainTextExtraBold  // 메인 타이틀에 굵은 폰트 적용
        case .subTitle:
            return Font.mainTextMedium16   // 서브 타이틀은 중간 굵기
        }
    }
    
    /// 각 텍스트에 적용할 텍스트 색상
    var fontColor: Color {
        switch self {
        case .title:
            return Color.black             // 메인 타이틀은 검정색
        case .subTitle:
            return Color.gray01            // 서브 타이틀은 연한 회색
        }
    }
}
