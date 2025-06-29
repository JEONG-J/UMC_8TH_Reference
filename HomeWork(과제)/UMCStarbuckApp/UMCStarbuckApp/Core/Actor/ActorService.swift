//
//  ActorService.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/26/25.
//

import Foundation

class ActorService {
    let storeDataManager: StoreDataManager
    
    init(
        storeDataManager: StoreDataManager = .init()
    ) {
        self.storeDataManager = storeDataManager
    }
}
