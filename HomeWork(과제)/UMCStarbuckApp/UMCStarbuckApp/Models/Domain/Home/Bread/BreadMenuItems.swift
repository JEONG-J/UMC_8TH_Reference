//
//  BreadMenuItems.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/20/25.
//

import Foundation
import SwiftUI

struct BreadMenuItems: Identifiable, MenuItemAttr {
    let id: UUID = .init()
    var name: String
    var thumbnailImage: ImageResource
}
