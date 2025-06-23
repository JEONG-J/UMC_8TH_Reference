//
//  ShopViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import Foundation

@Observable
class ShopViewModel {
    var onLineData: [OnLineItems] = OnLineItemsData.onLineItems
    var allProducts: [ProductItems] = ProductItemsData.productItems
    var bestItems: [BestItems] = BestItemsData.bestItems
    var newItems: [NewProductsItems] = NewProductItemsData.newProductsItems
    
    var bestItemsPageCount: Int = 0
}
