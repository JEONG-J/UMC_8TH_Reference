//
//  GreenSegmentStyle.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/27/25.
//

import Foundation
import SwiftUI

struct GreenSegmentStyle: CustomSegmentStyle {
    var capsuleOffset: CGFloat = 3
    var showSegmentBackground: Bool = true
    var segmentColor: Color = Color.green01
    var segmentHSpacing: CGFloat = .zero
    var segmentVSpacing: CGFloat = .zero
    var segmentHeight: CGFloat = 3
    var segmentWidthMode: CapsuleWidthMode = .fullWidth
    
    func horizontalPadding(segment: any SegmentAttr, isFirst: Bool) -> (CGFloat, CGFloat) {
        if let segment = segment as? OrderSegment {
            switch segment {
            case .cakeMenu:
                return (50, 27)
            default:
                return isFirst ? (30, 30) : (23, 23)
            }
        } else {
            return (0, 0)
        }
    }
}
