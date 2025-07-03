//
//  SearchResult.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/30/25.
//

import Foundation

/// 장소 검색 모델
struct SearchResult: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let coordinate: Coordinate
}
