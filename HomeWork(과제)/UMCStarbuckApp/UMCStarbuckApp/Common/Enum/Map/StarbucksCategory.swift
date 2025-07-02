//
//  StarbucksCategory.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/25/25.
//

import Foundation
import SwiftUI

/// 스타벅스 매장의 카테고리를 나타내는 열거형입니다.
/// - `reserve`: 리저브 매장 (스페셜티 원두 및 고급화 콘셉트 매장)
/// - `dt`: 드라이브 스루(DT) 매장
/// - `all`: 리저브와 DT를 모두 포함하는 매장
/// - `none`: 특별한 카테고리 분류가 없는 경우 (기본 매장 등)
///
/// `Codable`을 채택하여 서버와의 데이터 송수신 시 인코딩/디코딩이 가능합니다.
/// `RawValue`로 한글 문자열을 사용하므로 JSON과 쉽게 매핑할 수 있습니다.
enum StartbucksCategory: String, Codable {
    
    /// 리저브 매장
    case reserve = "리저브 매장"
    
    /// 드라이브 스루 매장
    case dt = "DT 매장"
    
    /// 리저브 + 드라이브 스루 매장
    case all = "DTR 매장"
    
    /// 분류 없음
    case none = ""
    
    /// 매장 카테고리에 따라 필요한 이미지 리소스를 반환합니다.
    /// 뷰에서 아이콘 등을 표시할 때 사용됩니다.
    var imageResources: [ImageResource] {
        switch self {
        case .reserve:
            return [.reserveStore]
        case .dt:
            return [.dtStore]
        case .all:
            return [.reserveStore, .dtStore]
        case .none:
            return []
        }
    }
}
