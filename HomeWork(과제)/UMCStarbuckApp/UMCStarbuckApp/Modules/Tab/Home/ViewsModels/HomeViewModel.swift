//
//  HomeViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation
import SwiftUI

/// 홈 화면에서 사용되는 ViewModel
@Observable
class HomeViewModel {
    
    // MARK: - Property
    
    /// 배너, 섹션 등의 데이터를 합쳐서 구성한 홈 화면 콘텐츠 배열
    var mergedContents: [HomeContentItem] = []
    
    /// 의존성 주입을 위한 컨테이너
    let container: DIContainer
    
    /// Keychain을 통해 사용자 정보를 불러오기 위한 매니저
    let keychainManager: KeychainManager = .standard
    
    // MARK: - Init
    
    /// DIContainer를 받아 초기화하며 더미 데이터를 불러옴
    init(container: DIContainer) {
        self.container = container
        self.loadDummyData()
    }
    
    // MARK: - Method
    
    /// 더미 데이터를 로드하여 `mergedContents` 배열을 구성
    /// 배너와 특정 인덱스에 섹션을 삽입하는 방식으로 콘텐츠를 생성
    private func loadDummyData() {
        let banners =  BannerDataSource.bannerItems            // 배너 데이터
        let coffees = CoffeeDataSource.summaryItems           // 추천 커피 데이터
        let whatNew = WhatsNewDataSource.whatsNewItems        // 새 소식 데이터
        let breads = BreadDataSource.breadItems               // 디저트(빵) 데이터
        
        var merged: [HomeContentItem] = []                    // 최종 병합된 콘텐츠 배열
        var bannerIndex = 0                                   // 배너 인덱스 추적
        
        // 특정 인덱스에 삽입될 섹션들
        let sectionInsertIndices: [Int: HomeSection] = [
            2: .init(title: "\(loadName())님을 위한 추천 메뉴", items: coffees, contentType: .coffee),
            4: .init(title: "What’s New", items: whatNew, contentType: .whatsNew),
            9: .init(title: "하루가 달콤해지는 디저트", items: breads, contentType: .dessert)
        ]
        
        // 배너와 섹션을 혼합하여 merged 배열 구성
        for i in 0..<(banners.count + sectionInsertIndices.count) {
            if let section = sectionInsertIndices[i] {
                merged.append(.section(section))              // 지정된 위치에 섹션 삽입
            } else if bannerIndex < banners.count {
                merged.append(.banner(banners[bannerIndex])) // 그 외에는 배너 삽입
                bannerIndex += 1
            }
        }
        
        self.mergedContents = merged
    }
    
    /// Keychain에서 사용자 이름을 불러옴
    /// 값이 없을 경우 "(설정 닉네임)"을 기본값으로 반환
    private func loadName() -> String {
        let user = keychainManager.loadSession(for: "UMCStarbuckApp")
        return user?.userName ?? "(설정 닉네임)"
    }
}
