//
//  FindStoreViewModels.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/27/25.
//

import Foundation

@Observable
class FindStoreViewModel {
    // MARK: - State Property
    var isSearchLoading: Bool = false
    var showSearchAlert: Bool = false
    
    // MARK: - Property
    var findStoreSegment: FindStoreSegment = .findStore
    var routePosition: RoutePosition = .departure
    var textfieldValue: [RoutePosition: String] = {
        var dict: [RoutePosition: String] = [:]
        RoutePosition.allCases.forEach { dict[$0] = ""}
        return dict
    }()
    
    var container: DIContainer
    var searchResult: [SearchResult] = [
        .init(name: "중앙대학교", address: "서울 동작구 흑석동 221"),
        .init(name: "어후홍콩 중앙대본점", address: "서울 동작구 흑석동 221"),
        .init(name: "중앙대학교병원 주차장", address: "서울 동작구 흑석동 221"),
        .init(name: "블라블라", address: "서울 동작구 흑석동 221"),
        .init(name: "중앙대학교", address: "서울 동작구 흑석동 221"),
        .init(name: "어후홍콩 중앙대본점", address: "서울 동작구 흑석동 221"),
        .init(name: "중앙대학교병원 주차장", address: "서울 동작구 흑석동 221"),
        .init(name: "블라블라", address: "서울 동작구 흑석동 221"),
        .init(name: "중앙대학교", address: "서울 동작구 흑석동 221"),
        .init(name: "어후홍콩 중앙대본점", address: "서울 동작구 흑석동 221"),
        .init(name: "중앙대학교병원 주차장", address: "서울 동작구 흑석동 221"),
        .init(name: "블라블라", address: "서울 동작구 흑석동 221"),
        .init(name: "중앙대학교", address: "서울 동작구 흑석동 221"),
        .init(name: "어후홍콩 중앙대본점", address: "서울 동작구 흑석동 221"),
        .init(name: "중앙대학교병원 주차장", address: "서울 동작구 흑석동 221"),
        .init(name: "블라블라", address: "서울 동작구 흑석동 221")
    ]
    
    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
    }
    
}
