//
//  FindStoreSegment.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/27/25.
//

import Foundation
import SwiftUI

enum FindStoreSegment: String, SegmentAttr {
    case findStore = "매장 찾기"
    case findeRoad = "길찾기"
    
    var segmentTitle: String {
        return self.rawValue
    }
    
    var segmentFont: Font {
        return .mainTextSemiBold24
    }
}
