//
//  ReceiptSegement.swift
//  4st_Practice
//
//  Created by Apple Coding machine on 4/1/25.
//

import Foundation
enum ReceiptSegment: Int, CaseIterable, Identifiable {
    case first
    case second
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .first:
            return "첫 번째"
        case .second:
            return "두 번째"
        }
    }
    
    var imageName: String {
        switch self {
        case .first:
            return "first"
        case .second:
            return "second"
        }
    }
}
