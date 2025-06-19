//
//  TabCase.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation
import SwiftUI

enum TabCase: String, CaseIterable {
    case home = "Home"
    case pay = "Pay"
    case order = "Order"
    case shop = "Shop"
    case other = "Other"
    
    var icon: Image {
        switch self {
        case .home:
            return .init(.home)
        case .pay:
            return .init(.pay)
        case .order:
            return .init(.order)
        case .shop:
            return .init(.shop)
        case .other:
            return .init(.other)
        }
    }
}
