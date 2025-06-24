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
    let beforeStickyPinnedHeight: CGFloat
    let affterStickyPinnedHeight: CGFloat
    let lazySpacing: CGFloat
    let background: Color
    let titlePadding: CGFloat?

    
    init(orderHeader: String) {
        self.pinnedHeaderText = orderHeader
        self.stickyHeaderHeight = 40
        self.beforeStickyPinnedHeight = 10
        self.affterStickyPinnedHeight = 80
        self.lazySpacing = 26
        self.background = Color.white
        self.titlePadding = 23
    }
}
