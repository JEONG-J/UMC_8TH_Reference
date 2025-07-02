//
//  SubSegment.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import Foundation

/// 주문 화면 등에서 세부 카테고리를 구분할 때 사용하는 서브 세그먼트 타입입니다.
/// - `beverages`: 음료 메뉴 (커피, 티, 주스 등)
/// - `food`: 푸드 메뉴 (베이커리, 샌드위치 등)
/// - `products`: 상품 (텀블러, 머그컵 등 굿즈)
///
/// `CaseIterable`을 채택하여 모든 항목을 순회하거나 세그먼트 UI에 활용할 수 있습니다.
enum SubSegmentType: String, CaseIterable {
    
    /// 음료 카테고리
    case beverages = "음료"
    
    /// 푸드 카테고리
    case food = "푸드"
    
    /// 상품 카테고리 (굿즈 등)
    case products = "상품"
}
