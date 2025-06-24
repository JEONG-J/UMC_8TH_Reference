//
//  OrderSegment.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import Foundation
import SwiftUI

enum OrderSegment: String, SegmentAttr {
    case allMenu = "전체 메뉴"
    case myMenu = "나만의 메뉴"
    case cakeMenu = "홀케이크 예약"
    
    var segmentTitle: String {
        self.rawValue
    }
    
    var segmentColor: Color {
        switch self {
        case .cakeMenu:
            return Color.green01
        default:
            return Color.black01
        }
    }
}
