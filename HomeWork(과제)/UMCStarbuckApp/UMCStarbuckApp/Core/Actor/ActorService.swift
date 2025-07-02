//
//  ActorService.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/26/25.
//

import Foundation

/// 앱 내에서 사용할 Actor 기반의 서비스를 모듈화한 클래스입니다.
/// 각종 데이터 관리 Actor(예: StoreDataManager)를 주입받아 사용합니다.
class ActorService {
    
    // MARK: - Properties
    
    /// 매장 데이터 관련 처리를 담당하는 Actor.
    /// 비동기적인 작업(예: 파일 로딩, 필터링 등)에 사용됩니다.
    let storeDataManager: StoreDataManager
    
    // MARK: - Init
    
    /// ActorService 초기화 메서드
    /// 외부에서 `StoreDataManager`를 주입받거나 기본값으로 초기화합니다.
    ///
    /// - Parameter storeDataManager: 사용할 `StoreDataManager` 인스턴스 (기본값: 새로 생성)
    init(
        storeDataManager: StoreDataManager = .init()
    ) {
        self.storeDataManager = storeDataManager
    }
}
