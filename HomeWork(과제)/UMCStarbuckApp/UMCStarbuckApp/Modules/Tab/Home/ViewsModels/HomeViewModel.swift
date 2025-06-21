//
//  HomeViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation
import SwiftUI

@Observable
class HomeViewModel {
    // MARK: - Property
    var mergedContents: [HomeContentItem] = []
    
    let container: DIContainer
    let keychainManager: KeychainManager = .standard
    
    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
        self.loadDummyData()
    }
    
    // MARK: - Method
    private func loadDummyData() {
        let banners =  BannerDataSource.bannerItems
        let coffees = CoffeeDataSource.summaryItems
        let whatNew = WhatsNewDataSource.whatsNewItems
        let breads = BreadDataSource.breadItems
        
        var merged: [HomeContentItem] = []
        
        var bannerIndex = 0
        let sectionInsertIndices: [Int: HomeSection] = [
            2: .init(title: "\(loadName())님을 위한 추천 메뉴", items: coffees, contentType: .coffee),
            4: .init(title: "What’s New", items: whatNew, contentType: .whatsNew),
            9: .init(title: "하루가 달콤해지는 디저트", items: breads, contentType: .dessert)
        ]
        
        for i in 0..<(banners.count + sectionInsertIndices.count) {
            if let section = sectionInsertIndices[i] {
                merged.append(.section(section))
            } else if bannerIndex < banners.count {
                merged.append(.banner(banners[bannerIndex]))
                bannerIndex += 1
            }
        }
        
        self.mergedContents = merged
    }
    
    private func loadName() -> String {
        let user = keychainManager.loadSession(for: "UMCStarbuckApp")
        return user?.userName ?? "(설정 닉네임)"
    }
}
