//
//  CustomSegmentStyle.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/27/25.
//

import Foundation
import SwiftUI

protocol CustomSegmentStyle {
    var capsuleOffset: CGFloat { get }
    var showSegmentBackground: Bool { get }
    var segmentHSpacing: CGFloat { get }
    var segmentVSpacing: CGFloat { get }
    var segmentHeight: CGFloat { get }
    var segmentWidthMode: CapsuleWidthMode { get }
    var segmentColor: Color { get }
    
    func horizontalPadding(segment: any SegmentAttr, isFirst: Bool) -> (CGFloat, CGFloat)
}
