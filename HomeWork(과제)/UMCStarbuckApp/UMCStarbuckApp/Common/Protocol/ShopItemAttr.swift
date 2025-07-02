//
//  ShopItemAttr.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import Foundation
import SwiftUI

/// 쇼핑 탭에 표시될 아이템(굿즈, 머그컵, 텀블러 등)이 공통적으로 가져야 할 속성을 정의한 프로토콜입니다.
/// 이 프로토콜을 채택하면 다양한 상품 타입을 동일한 방식으로 UI에 바인딩하거나 리스트로 출력할 수 있습니다.
protocol ShopItemAttr {
    
    /// 상품의 이름 (예: 스타벅스 텀블러, 한정판 머그 등)
    var name: String { get }
    
    /// 상품의 이미지 리소스
    /// SwiftGen 등으로 관리되는 `ImageResource` 타입 사용
    var image: ImageResource { get }
}
