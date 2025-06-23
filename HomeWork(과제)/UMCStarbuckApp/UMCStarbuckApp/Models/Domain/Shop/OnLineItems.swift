//
//  OnLine.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/21/25.
//

import Foundation
import SwiftUI

struct OnLineItems: Identifiable {
    let id: UUID = .init()
    let image: ImageResource
}

struct OnLineItemsData {
    static let onLineItems: [OnLineItems] = [
        .init(image: .shopFirst),
        .init(image: .shopSecond),
        .init(image: .shopThird)
    ]
}
