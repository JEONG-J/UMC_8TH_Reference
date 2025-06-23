//
//  NewProductsItems.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import Foundation
import SwiftUI

struct NewProductsItems: Identifiable, ShopItemAttr {
    let id: UUID = .init()
    var image: ImageResource
    var name: String
}

struct NewProductItemsData {
    static let newProductsItems: [NewProductsItems] = [
        .init(image: .newFirst, name: "그린 사이렌 도트 머그 237ml"),
        .init(image: .newSecond, name: "그린 사이렌 도트 머그 355ml"),
        .init(image: .newThird, name: "홈 카페 미니 머그 세트"),
        .init(image: .newFourth, name: "홈 카페 글라스 세트")
    ]
}
