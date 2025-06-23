//
//  TopController.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import Foundation
import SwiftUI

enum TopControlType: String, CaseIterable, Identifiable {
    case starHistory = "별 히스토리"
    case receipt = "전자영수증"
    case myMenu = "나만의 메뉴"
    
    var id: String { rawValue }
    
    var image: ImageResource {
        switch self {
        case .starHistory:
            return .starHistory
        case .receipt:
            return .receipt
        case .myMenu:
            return .my
        }
    }
    
    var font: Font {
        return .mainTextSemiBold16
    }
    
    var color: Color {
        return Color.black03
    }
}
