//
//  OrderViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import Foundation

@Observable
class OrderViewModel {
    var subSegmentType: SubSegmentType = .beverages
    var selectedSegment: OrderSegment = .allMenu
    var showMapSheet: Bool = false
    var storeAddressName: String? = nil
}
