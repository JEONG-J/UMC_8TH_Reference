//
//  StoreSelectSheetViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/24/25.
//

import Foundation
import CoreLocation
import SwiftUI
import Moya

/// 매장 선택 시트(StoreSelectSheet)에서 사용되는 뷰모델입니다.
/// 위치 기반 매장 검색, 전체 매장 로딩, 검색어 상태 등을 관리합니다.
@Observable
class StoreSelectSheetViewModel {
    
    // MARK: - 검색 및 필터 상태
    var textSearch: String = ""                          // 검색창에 입력된 텍스트
    var storeSearchType: StoreSearchType = .nearStore    // 선택된 매장 검색 필터 (예: 가까운 매장)
    
    // MARK: - 매장 리스트
    var storeList: [Feature] = []        // 화면에 보여줄 필터링된 매장 리스트
    var storeImageMap: [String: String] = [:]

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
        
        let imageMap = await mapStoreImage(features: result)
        self.storeImageMap = imageMap
        
        isLoading = false
    }
    
    // MARK: - API
    
    private func mapStoreImage(features: [Feature]) async -> [String: String] {
        var imageMap: [String: String] = [:]
        
        await withTaskGroup(of: (String, String?).self) { group in
            for feature in features {
                let storeName = feature.properties.storeName
                let featureID = feature.id
                
                group.addTask(operation: {
                    let photoRef = await self.getPhotoReference(query: storeName)
                    let imageUrl = photoRef.map { self.makeImageUrl($0)}
                    return (featureID, imageUrl)
                })
            }
            
            for await (id, url) in group {
                if let url = url {
                    imageMap[id] = url
                }
            }
        }
        return imageMap
    }
    
    private func getPhotoReference(query: String) async -> String? {
        let fullQuery = "스타벅스 \(query)점"
        
        do {
            return try await container.useCaseService.googleService.getPhotoReference(query: fullQuery)
        } catch let error as GooglePlaceError {
            print("[PhotoRef] \(query) 실패: \(error.localizedDescription)")
        } catch {
            print("[PhotoRef] \(query) 알 수 없는 에러: \(error)")
        }
        return nil
    }
    
    
    private func makeImageUrl(_ photoReference: String) -> String {
        return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1024&photoreference=\(photoReference)&key=\(Config.googleKey)"
    }
}
