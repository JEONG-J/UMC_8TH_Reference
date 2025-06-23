//
//  IdentifiableImageData.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import Foundation

struct IdentifiableImageData: Identifiable {
    let id: UUID = .init()
    let data: Data
}
