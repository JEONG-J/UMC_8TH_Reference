//
//  StoreSearchType.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/25/25.
//

import Foundation

enum StoreSearchType: String, CaseIterable, Identifiable {
    case nearStore = "가까운 매장"
    case favoriteStore = "자주가는 매장"
    
    var id: String { self.rawValue }
}
