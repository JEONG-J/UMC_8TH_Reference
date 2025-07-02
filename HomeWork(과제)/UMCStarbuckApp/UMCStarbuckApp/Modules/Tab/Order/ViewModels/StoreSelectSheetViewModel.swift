//
//  StoreSelectSheetViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import Foundation
import CoreLocation
import SwiftUI

/// 매장 선택 시트(StoreSelectSheet)에서 사용되는 뷰모델입니다.
/// 위치 기반 매장 검색, 전체 매장 로딩, 검색어 상태 등을 관리합니다.
@Observable
class StoreSelectSheetViewModel {
    
    // MARK: - 검색 및 필터 상태
    var textSearch: String = ""                          // 검색창에 입력된 텍스트
    var storeSearchType: StoreSearchType = .nearStore    // 선택된 매장 검색 필터 (예: 가까운 매장)
    
    // MARK: - 매장 리스트
    var allStores: [Feature] = []        // 전체 매장 데이터 (GeoJSON에서 로드됨)
    var storeList: [Feature] = []        // 화면에 보여줄 필터링된 매장 리스트
    var googleStoreImageUrl: String?     // 매장 관련 구글 이미지 URL (옵션)

    // MARK: - 의존성
    let locationManager: LocationManager = .shared       // 현재 위치 정보
    let container: DIContainer                           // DI 컨테이너 (서비스 주입)
    
    // MARK: - 초기화
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - 로딩 상태 표시
    var isLoading: Bool = false      // 매장 데이터 로딩 여부 표시
    
    // MARK: - 전체 매장 데이터 로드
    /// GeoJSON에서 전체 매장 데이터를 로드하여 allStores에 저장합니다.
    @MainActor
    public func getAllStores() async {
        isLoading = true
        await container.actorService.storeDataManager.loadAllStores()
        allStores = await container.actorService.storeDataManager.allStores
        isLoading = false
    }
    
    // MARK: - 주변 매장 필터링
    /// 현재 위치 기준으로 주변 매장을 필터링하여 storeList에 저장합니다.
    @MainActor
    public func nearByStores() async {
        guard let userLocaton = locationManager.currentLocation else {
            print("현재 위치 정보 없음")
            return
        }
        isLoading = true
        let result = await container.actorService.storeDataManager.nearbyStores(userLocation: userLocaton)
        storeList = result
        isLoading = false
    }
}
