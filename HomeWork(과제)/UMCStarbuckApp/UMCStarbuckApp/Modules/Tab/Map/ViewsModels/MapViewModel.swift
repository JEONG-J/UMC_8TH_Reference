//
//  MapViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/26/25.
//

import MapKit
import SwiftUI

/// Starbucks 지도 화면에서 지도 상태 및 매장 데이터를 관리하는 뷰모델입니다.
@MainActor
@Observable
class MapViewModel {
    
    // MARK: - 지도 관련 상태
    var hasInitializedMap: Bool = false          // 최초 카메라 초기화 여부
    var hasDraggedMap: Bool = false              // 사용자가 지도를 드래그했는지 여부
    
    var previousCameraCenter: CLLocationCoordinate2D?  // 이전 카메라 중심 좌표
    var filteredStores: [Feature] = []           // 필터링된 매장 목록
    var allStores: [Feature] = []                // 전체 매장 목록
    
    var visibleRegion: MKCoordinateRegion? = nil // 현재 화면에 보이는 지도 영역
    var cameraPosition: MapCameraPosition        // SwiftUI 지도 카메라 상태 바인딩
    
    var container: DIContainer                   // 의존성 주입 컨테이너
    
    // MARK: - Init
    
    init(container: DIContainer) {
        self.container = container
        self.cameraPosition = MapViewModel.moveToCurrentLocation()
    }
    
    // MARK: - 현재 위치로 카메라 초기화
    
    /// 현재 위치를 기준으로 MapCameraPosition(region)을 반환합니다.
    static func moveToCurrentLocation() -> MapCameraPosition {
        guard let coordinate = LocationManager.shared.currentLocation?.coordinate else {
            return .automatic
        }

        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 800, longitudinalMeters: 800
        )
        return .region(region)
    }
    
    // MARK: - 매장 데이터 로딩
    
    /// GeoJSON에서 전체 매장 목록을 로드합니다.
    func loadStores() async {
        await container.actorService.storeDataManager.loadAllStores()
        self.allStores = await container.actorService.storeDataManager.allStores
    }
    
    /// 현재 사용자 위치 기준으로 10km 이내 매장만 필터링합니다.
    func searchFilterStore() async {
        if let userLocation = LocationManager.shared.currentLocation {
            let nearby = await container.actorService.storeDataManager.nearbyStores(userLocation: userLocation)
            filteredStores = nearby
        }
    }
    
    /// 지도 중심 좌표를 기준으로 반경 5km 이내 매장만 필터링합니다.
    func enterTheMapSearch(_ center: CLLocationCoordinate2D?) async {
        guard let center = center else { return }
        let userCL = CLLocation(latitude: center.latitude, longitude: center.longitude)

        filteredStores = allStores.filter {
            let storeLoc = CLLocation(latitude: $0.properties.latitude, longitude: $0.properties.longitude)
            return userCL.distance(from: storeLoc) <= 5000
        }
    }
    
    // MARK: - 지도 위치 변경 감지
    
    /// 지도 카메라가 이동했을 때 위치를 기록하고, 일정 거리 이상 움직였는지 체크합니다.
    func mapCameraChange(_ region: MKCoordinateRegion) {
        let currentCenter = region.center
        visibleRegion = region

        // 첫 초기화일 경우 상태 초기화
        guard hasInitializedMap else {
            hasInitializedMap = true
            previousCameraCenter = currentCenter
            return
        }

        // 이전 위치와의 거리 차이 계산
        if let previous = previousCameraCenter {
            let distance = CLLocation(latitude: previous.latitude, longitude: previous.longitude)
                .distance(from: CLLocation(latitude: currentCenter.latitude, longitude: currentCenter.longitude))

            // 50m 이상 이동 시 지도 드래그 상태로 판단
            if distance > 50 {
                hasDraggedMap = true
            }
        }

        // 이전 중심 갱신
        previousCameraCenter = currentCenter
    }
}


/// MKCoordinateRegion 안에 특정 좌표가 포함되는지 판단하는 확장 메서드입니다.
extension MKCoordinateRegion {
    func contains(_ coordinate: CLLocationCoordinate2D) -> Bool {
        let minLat = center.latitude - span.latitudeDelta / 2
        let maxLat = center.latitude + span.latitudeDelta / 2
        let minLng = center.longitude - span.longitudeDelta / 2
        let maxLng = center.longitude + span.longitudeDelta / 2
        
        return (minLat...maxLat).contains(coordinate.latitude) &&
               (minLng...maxLng).contains(coordinate.longitude)
    }
}
