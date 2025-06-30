//
//  RoutePosition.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/29/25.
//

import Foundation
import SwiftUI

enum RoutePosition: String, CaseIterable {
    case departure = "출발"
    case arrival = "도착"
    
    var placeholder: String {
        switch self {
        case .departure:
            return "출발지 입력"
        case .arrival:
            return "매장명 또는 주소"
        }
    }
    
    var isCurrentButton: Bool {
        return self == .departure
    }
}
