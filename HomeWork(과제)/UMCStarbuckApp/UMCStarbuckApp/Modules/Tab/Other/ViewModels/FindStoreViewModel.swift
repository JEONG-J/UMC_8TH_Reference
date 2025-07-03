//
//  FindStoreViewModels.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/27/25.
//

import Foundation
import MapKit

/// 매장 찾기 화면에서 사용하는 ViewModel
@Observable
class FindStoreViewModel {
    
    // MARK: - State Property
    
    /// 검색 중 로딩 상태를 나타냄 (로딩 인디케이터 표시 용도)
    var isSearchLoading: Bool = false
    
    /// 검색 실패 또는 입력 누락 시 경고창 노출 여부
    var showSearchAlert: Bool = false
    
    // MARK: - Property
    
    /// 현재 선택된 세그먼트 (ex. 매장 찾기 / 경로 찾기)
    var findStoreSegment: FindStoreSegment = .findStore
    
    /// 경로 검색 시 사용자의 현재 선택 위치 (출발지 또는 도착지)
    var routePosition: RoutePosition = .arrival
    
    /// 각 위치(출발/도착)에 대한 텍스트 필드 값 저장
    var textfieldValue: [RoutePosition: String] = {
        var dict: [RoutePosition: String] = [:]
        RoutePosition.allCases.forEach { dict[$0] = "" }
        return dict
    }()
    
    /// DI 컨테이너 (의존성 주입용)
    var container: DIContainer
    
    /// 장소 검색 결과 리스트
    var searchResult: [SearchResult] = []
    
    /// OSRM 경로 요청을 위한 시작점과 도착점 좌표
    var osrmRequestPoint: OSRMRouteRequset = .init(
        startPoint: .init(lat: 0, lng: 0),
        endPoint: .init(lat: 0, lng: 0)
    )
    
    /// OSRM 경로 응답 데이터 (geometry 등 포함)
    var osrmResponsePoint: OSRMRouteResponse?
    
    // MARK: - Init
    
    /// DIContainer를 통해 초기화
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - 키워드 장소 검색
    
    /// 출발/도착지 위치 기반으로 장소 검색 요청
    @MainActor
    public func searchPlace(position: RoutePosition) async {
        let query = validatedQuery(for: position)
        
        guard !query.isEmpty else {
            showSearchAlert = true
            return
        }
        
        isSearchLoading = true
        defer { isSearchLoading = false }
        
        do {
            let places = try await getKeywordPlaces(query: query)
            updateSearchResults(places)
        } catch {
            print("검색 실패: \(error.localizedDescription)")
            showSearchAlert = true
        }
    }
    
    /// 입력값 공백 제거 및 유효성 검사
    private func validatedQuery(for position: RoutePosition) -> String {
        let raw = textfieldValue[position] ?? ""
        return raw.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// 카카오 키워드 검색 API 호출
    private func getKeywordPlaces(query: String) async throws -> [KakaoPlaceDocument] {
        let places = try await container.useCaseService.kakaoService.getKeywordPlace(query: query)
        
        if places.isEmpty {
            print("검색 결과 없음")
            showSearchAlert = true
        }
        return places
    }

    /// 검색 결과를 내부 모델로 변환하여 저장
    private func updateSearchResults(_ places: [KakaoPlaceDocument]) {
        guard !places.isEmpty else { return }
        
        self.searchResult = places.map {
            SearchResult(
                name: $0.placeName,
                address: $0.roadAddressName.isEmpty ? $0.addressName : $0.roadAddressName,
                coordinate: .init(lat: Double($0.y) ?? 0, lng: Double($0.x) ?? 0)
            )
        }
    }
    
    // MARK: - 매장명 검색 (내부 데이터 기준)
    
    /// 매장명 기반으로 검색 (정확 일치 → 포함 순서)
    public func searchStores(keyword: String) async {
        isSearchLoading = true
        defer { isSearchLoading = false }
        
        let trimmedKeyword = keyword.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        guard !trimmedKeyword.isEmpty else {
            showSearchAlert = true
            return
        }
        
        let exactMatch = await filterExactMatch(keyword: trimmedKeyword)
        
        if let exactMatch {
            self.searchResult = [mapToSearchResult(from: exactMatch)]
            return
        }
        
        let partialMatches = await filterPartialMatches(keyword: trimmedKeyword)
        
        if partialMatches.isEmpty {
            showSearchAlert = true
        } else {
            self.searchResult = partialMatches.map(mapToSearchResult(from:))
        }
    }

    /// 정확히 일치하는 매장을 찾음
    private func filterExactMatch(keyword: String) async -> Feature? {
        return await container.actorService.storeDataManager.allStores.first(where: {
            $0.properties.storeName.lowercased() == keyword
        })
    }

    /// 포함된 키워드가 있는 매장 리스트 반환
    private func filterPartialMatches(keyword: String) async -> [Feature] {
        return await container.actorService.storeDataManager.allStores.filter {
            $0.properties.storeName.lowercased().contains(keyword)
        }
    }

    /// Feature 객체를 SearchResult로 변환
    private func mapToSearchResult(from feature: Feature) -> SearchResult {
        return SearchResult(
            name: feature.properties.storeName,
            address: feature.properties.address,
            coordinate: .init(lat: feature.properties.latitude,
                              lng: feature.properties.longitude)
        )
    }
    
    // MARK: - 경로 탐색 (OSRM)
    
    /// OSRM 서버에 경로 탐색 요청
    public func getRouteInOSRM() async {
        isSearchLoading = true
        defer { isSearchLoading = false }
        
        do {
            let routes = try await container.useCaseService.osrmService.getRouteRoad(route: osrmRequestPoint)
            guard let geometry = routes.routes.first?.geometry else {
                print("geometry 없음")
                return
            }
            let polyline = convertGeoJSONCoordinatesToPolyline(geometry.coordinates)
            await container.actorService.mapRouteDataManager.setPolyline(polyline)
        } catch {
            print("경로 요청 실패: \(error.localizedDescription)")
        }
    }
    
    /// GeoJSON 좌표 데이터를 MKPolyline 객체로 변환
    private func convertGeoJSONCoordinatesToPolyline(_ coordinates: [[Double]]) -> MKPolyline {
        let clCoordinates = coordinates.map { CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0]) }
        return MKPolyline(coordinates: clCoordinates, count: clCoordinates.count)
    }
}
