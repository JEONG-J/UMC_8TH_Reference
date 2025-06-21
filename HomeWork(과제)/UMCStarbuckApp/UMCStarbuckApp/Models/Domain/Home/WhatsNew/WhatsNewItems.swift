//
//  WhatsNewItems.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/20/25.
//

import Foundation
import SwiftUI

struct WhatsNewItems: Identifiable {
    let id: UUID = .init()
    let image: ImageResource
    let name: String
    let description: String
}
