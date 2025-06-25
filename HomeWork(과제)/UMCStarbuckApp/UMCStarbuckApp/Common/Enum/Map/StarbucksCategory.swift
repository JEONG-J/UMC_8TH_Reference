//
//  StarbucksCategory.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/25/25.
//

import Foundation
import SwiftUI

enum StartbucksCategory: String, Codable {
    case reserve = "리저브 매장"
    case dt = "DT 매장"
    case all = "DTR 매장"
    case none = ""
    
    var imageResources: [ImageResource] {
        switch self {
        case .reserve:
            return [.reserveStore]
        case .dt:
            return [.dtStore]
        case .all:
            return [.reserveStore, .dtStore]
        case .none:
            return []
        }
    }
}
