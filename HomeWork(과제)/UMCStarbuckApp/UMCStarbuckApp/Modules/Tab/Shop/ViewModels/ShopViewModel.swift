//
//  ShopViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import Foundation

@Observable
class ShopViewModel {
    var onLineData: [OnLineItem] = OnLineItemsData.onLineItems
    var allProducts: [ProductItem] = ProductItemsData.productItems
    var bestItems: [BestItems] = BestItemsData.bestItems
    var newItems: [NewProductsItem] = NewProductItemsData.newProductsItems
    
    var bestItemsPageCount: Int = 0
}
