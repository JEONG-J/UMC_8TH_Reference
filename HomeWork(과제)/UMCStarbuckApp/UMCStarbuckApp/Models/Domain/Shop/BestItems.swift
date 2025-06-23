//
//  BestItems.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import Foundation
import SwiftUI

struct BestItems: Identifiable, ShopItemAttr {
    let id: UUID = .init()
    var image: ImageResource
    var name: String
}

struct BestItemsData {
    static let bestItems: [BestItems] = [
        .init(image: .bestFirst, name: "그린 사이렌 슬리브 머그 355ml"),
        .init(image: .bestSecond, name: "그린 사이렌 클래식 머그 355ml"),
        .init(image: .bestThird, name: "사이렌 머그 앤 우드 소서"),
        .init(image: .bestFourth, name: "리저브 골드 테일 머그 355ml"),
        .init(image: .bestFifth, name: "블랙 앤 골드 머그 473ml"),
        .init(image: .bestSixth, name: "블랙 링 머그 355ml"),
        .init(image: .bestSeventh, name: "북청사자놀음 데미머그 89ml"),
        .init(image: .bestEighth, name: "서울 제주 데미머그 세트"),
    ]
}
