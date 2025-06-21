//
//  CoffeeSummaryItem.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/20/25.
//

import Foundation
import SwiftUI

struct CoffeeSummaryItem: Identifiable, MenuItemAttr {
    let id: UUID
    var name: String
    var thumbnailImage: ImageResource
}
