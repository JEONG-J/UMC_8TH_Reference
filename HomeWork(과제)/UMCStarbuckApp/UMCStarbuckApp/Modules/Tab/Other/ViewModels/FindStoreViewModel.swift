//
//  FindStoreViewModels.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/27/25.
//

import Foundation

/// 매장 찾기 화면에서 사용하는 ViewModel
@Observable
class FindStoreViewModel {
    
    // MARK: - State Property
    
    /// 검색 중 로딩 상태를 나타냄
    var isSearchLoading: Bool = false
    
    /// 검색 실패 또는 조건 미입력 등 경고창 노출 여부
    var showSearchAlert: Bool = false
    
    // MARK: - Property
    
    /// 현재 선택된 상단 세그먼트 (ex. 매장찾기 / 경로찾기)
    var findStoreSegment: FindStoreSegment = .findStore
    
    /// 경로 탐색 시 현재 선택된 포지션 (출발/도착)
    var routePosition: RoutePosition = .departure
    
    /// 각 포지션(출발, 도착)에 대응하는 텍스트필드 입력값을 저장
    var textfieldValue: [RoutePosition: String] = {
        var dict: [RoutePosition: String] = [:]
        RoutePosition.allCases.forEach { dict[$0] = "" }
        return dict
    }()
    
    /// 의존성 주입을 위한 DI 컨테이너
    var container: DIContainer
    
    /// 검색 결과 리스트
    var searchResult: [SearchResult] = []
    
    // MARK: - Init
    
    /// DI 컨테이너를 받아 초기화
    init(container: DIContainer) {
        self.container = container
    }
}
