//
//  StoreDataManager.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/26/25.
//

import Foundation
import CoreLocation

/// GeoJSON 파일로부터 스타벅스 매장 데이터를 비동기적으로 로드하고,
/// 사용자의 현재 위치를 기준으로 가까운 매장을 필터링해주는 Actor입니다.
/// Actor로 선언되어 있으므로 내부 상태는 thread-safe하게 보호됩니다.
actor StoreDataManager {
    
    /// 모든 매장 데이터를 저장하는 프로퍼티
    /// `loadAllStores()`를 호출하여 초기화해야 합니다.
    private(set) var allStores: [Feature] = []
    
    /// 번들 리소스에 있는 Starbucks.geojson 파일을 비동기적으로 로드하고 파싱하여
    /// `allStores`에 저장합니다.
    ///
    /// 실패할 경우 콘솔에 오류 메시지를 출력합니다.
    public func loadAllStores() async {
        guard let url = Bundle.main.url(forResource: "Starbucks", withExtension: "geojson"),
              let data = try? Data(contentsOf: url) else {
            print("GeoJSON 파일을 찾을 수 없습니다.")
            return
        }
        
        do {
            let geoJSON = try JSONDecoder().decode(StarbucksItem.self, from: data)
            self.allStores = geoJSON.features
        } catch {
            print("GeoJSON 디코딩 실패:", error.localizedDescription)
        }
    }
    
    /// 사용자의 현재 위치로부터 일정 거리 이내의 매장들을 반환합니다.
    /// 기본 검색 반경은 10km입니다.
    ///
    /// - Parameters:
    ///   - userLocation: 사용자의 현재 CLLocation 객체
    ///   - distanceKm: 필터링할 최대 거리 (기본값: 10,000m = 10km)
    /// - Returns: 거리 기준으로 정렬된 가까운 매장 리스트
    public func nearbyStores(userLocation: CLLocation, distanceKm: Double = 10_000) -> [Feature] {
        return allStores
            .filter { store in
                let loc = CLLocation(latitude: store.properties.latitude,
                                     longitude: store.properties.longitude)
                return userLocation.distance(from: loc) <= distanceKm
            }
            .sorted { lhs, rhs in
                let lhsLoc = CLLocation(latitude: lhs.properties.latitude, longitude: lhs.properties.longitude)
                let rhsLoc = CLLocation(latitude: rhs.properties.latitude, longitude: rhs.properties.longitude)
                return userLocation.distance(from: lhsLoc) < userLocation.distance(from: rhsLoc)
            }
    }
}
