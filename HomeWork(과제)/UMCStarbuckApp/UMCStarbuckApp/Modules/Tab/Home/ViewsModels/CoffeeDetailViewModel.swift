//
//  CoffeeDetailViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import Foundation

/// 커피 상세 화면에서 사용할 ViewModel
@Observable
class CoffeeDetailViewModel {
    
    /// 선택된 커피 메뉴 항목 (id로 조회한 객체)
    let coffee: CoffeeMenuItem
    
    /// 선택된 온도 (HOT 또는 ICED)
    var selectredTemperature: CoffeeTemperature

    /// 커피 ID를 기반으로 초기화
    /// 해당 ID에 해당하는 커피가 없으면 첫 번째 커피 항목을 기본값으로 설정
    init(coffeeId: UUID) {
        self.coffee = CoffeeDataSource.detailItems.first(where: { $0.id == coffeeId })
            ?? CoffeeDataSource.detailItems.first!
        self.selectredTemperature = self.coffee.availableTemperatures.first ?? .iced
    }

    /// 현재 선택된 온도에 해당하는 커피 상세 정보 (이미지, 설명 등)
    var selectedVariant: CoffeeVariant? {
        coffee.variants(temp: selectredTemperature)
    }

    /// 현재 선택된 온도에 따라 표시할 커피 이름 (예: "카페 아메리카노" 또는 "아이스 카페 아메리카노")
    var currentName: String {
        coffee.temperatureNames?[selectredTemperature]?.0 ?? coffee.name
    }

    /// 현재 선택된 온도에 따라 표시할 커피 영어 이름 (예: "Caffe Americano" 또는 "Iced Caffe Americano")
    var currentSubName: String {
        coffee.temperatureNames?[selectredTemperature]?.1 ?? coffee.subName
    }
}
