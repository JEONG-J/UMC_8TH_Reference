//
//  CoffeMenuItem.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/20/25.
//

import Foundation
import SwiftUI

/// 개별 커피 메뉴 정보를 담는 모델
struct CoffeeMenuItem: Identifiable {
    
    /// 고유 식별자
    let id: UUID
    
    /// 커피 이름 (예: "카라멜 마끼아또")
    let name: String
    
    /// 커피의 영문 이름 혹은 부제 (예: "Caramel Macchiato")
    let subName: String
    
    /// 가격 (단위: 원)
    let price: Int
    
    /// 온도별 커피 상세 정보 (이미지 및 설명 포함)
    let variants: [CoffeeTemperature: CoffeeVariant]
    
    /// 온도에 따라 라벨 텍스트 반환 (예: "HOT Only", "ICED Only")
    var temperatureLabel: String {
        let temps = Set(availableTemperatures)
        if temps == [.hot] {
            return "HOT Only"
        } else if temps == [.iced] {
            return "ICED Only"
        } else {
            return ""
        }
    }
    
    /// 온도별 이름 및 서브이름 커스텀 (예: 아이스일 때 다른 이름 표시)
    let temperatureNames: [CoffeeTemperature: (String, String)]?
    
    /// 사용 가능한 온도 리스트 반환 (예: [.hot, .iced])
    var availableTemperatures: [CoffeeTemperature] {
        Array(variants.keys)
    }
    
    /// 특정 온도의 커피 상세 정보 반환
    func variants(temp: CoffeeTemperature) -> CoffeeVariant? {
        variants[temp]
    }
}

/// 커피 온도별 상세 정보 구조체
struct CoffeeVariant {
    
    /// 해당 온도에서 보여줄 이미지
    let image: ImageResource
    
    /// 해당 온도에서의 설명 텍스트
    let description: String
}
