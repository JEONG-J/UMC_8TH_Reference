//
//  MeuItem.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/20/25.
//

import Foundation
import SwiftUI

/// 홈 배너 아이템 모델
struct BannerItem: Identifiable {
    let id: UUID = .init()
    let image: ImageResource
}
