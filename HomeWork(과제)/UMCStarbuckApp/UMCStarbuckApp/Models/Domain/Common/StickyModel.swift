//
//  StickyModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import Foundation
import SwiftUI

struct StickyModel {
    let pinnedHeaderText: String
    let stickyHeaderHeight: CGFloat
    let affterStickyPinnedHeight: CGFloat
    let lazySpacing: CGFloat
    let background: Color
    let titlePadding: CGFloat?

    
    init(orderHeader: String) {
        self.pinnedHeaderText = orderHeader
        self.stickyHeaderHeight = 40
        self.affterStickyPinnedHeight = 80
        self.lazySpacing = 26
        self.background = Color.white
        self.titlePadding = 23
    }
    
    init(shopHeader: String) {
        self.pinnedHeaderText = shopHeader
        self.stickyHeaderHeight = 30
        self.affterStickyPinnedHeight = 80
        self.lazySpacing = 16
        self.background = Color.white01
        self.titlePadding = nil
    }
}
