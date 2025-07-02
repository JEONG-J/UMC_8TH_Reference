//
//  SectionItem.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/20/25.
//

import Foundation

/// 홈 화면에서 사용할 콘텐츠 항목을 나타내는 열거형입니다.
/// 배너와 섹션(가로 스크롤뷰 형태의 추천 콘텐츠 등)을 구분하여 표현합니다.
enum HomeContentItem: Identifiable {
    /// 배너 콘텐츠 항목
    case banner(BannerItem)
    
    /// 가로 스크롤 형태의 섹션 콘텐츠 항목
    case section(HomeSection)

    /// 각 콘텐츠 항목의 고유 ID입니다.
    /// `Identifiable` 프로토콜을 채택하여 SwiftUI의 리스트나 ForEach 등에 사용될 수 있습니다.
    var id: UUID {
        switch self {
        case .banner(let item):
            return item.id
        case .section(let section):
            return section.id
        }
    }
}

/// 홈 화면의 섹션 콘텐츠 타입을 정의한 열거형입니다.
/// 각 케이스는 특정 카테고리의 콘텐츠를 나타냅니다.
enum HomeSectionType {
    /// 커피 관련 콘텐츠
    case coffee
    
    /// 신규 출시된 콘텐츠
    case whatsNew
    
    /// 디저트 관련 콘텐츠
    case dessert
}
