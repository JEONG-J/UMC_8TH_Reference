//
//  BrounSegmentStyle.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/27/25.
//

import Foundation
import SwiftUI

struct BrownSegmentStyle: CustomSegmentStyle {
    var capsuleOffset: CGFloat = .zero
    var showSegmentBackground: Bool = false
    var segmentColor: Color = Color.brown02
    var segmentHSpacing: CGFloat = 140
    var segmentVSpacing: CGFloat = 5
    var segmentHeight: CGFloat = 5
    var segmentWidthMode: CapsuleWidthMode = .textWidth
    func horizontalPadding(segment: any SegmentAttr, isFirst: Bool = false) -> (CGFloat, CGFloat) {
        return (.zero, .zero)
    }
    
}
