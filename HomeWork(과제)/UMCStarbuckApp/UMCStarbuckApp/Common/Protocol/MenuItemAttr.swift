//
//  MenuItemAttr.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import Foundation
import SwiftUI

/// 메뉴 아이템이 공통적으로 가져야 하는 속성을 정의한 프로토콜입니다.
/// 예: 커피, 푸드, 굿즈 등의 데이터 모델이 이 프로토콜을 채택하여 일관된 접근을 가능하게 합니다.
protocol MenuItemAttr {
    
    /// 메뉴의 이름 (예: 아메리카노, 치즈케이크 등)
    var name: String { get }
    
    /// 썸네일로 사용할 이미지 리소스
    /// SwiftGen 등의 도구를 통해 생성된 `ImageResource` 타입으로 관리
    var thumbnailImage: ImageResource { get }
}
