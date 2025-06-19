//
//  DIContainer.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import Foundation

/// 앱 전역에서 사용할 의존성 주입(Dependency Injection) 컨테이너 클래스
/// ViewModel, Router, UseCase 등 여러 공통 인스턴스를 중앙에서 주입하고 공유하기 위한 용도로 사용됨
class DIContainer: ObservableObject {
    
    /// 화면 전환을 제어하는 네비게이션 라우터
    /// SwiftUI의 View에서 상태 변화를 감지하고 반영할 수 있도록 @Published로 선언
    @Published var navigationRouter: NavigationRouter
    
    /// 유즈케이스 및 API 호출을 담당하는 서비스 객체
    /// API 요청, 데이터 가공 등 비즈니스 로직을 처리하는 UseCase 계층의 서비스
    @Published var useCaseService: UseCaseService
    
    /// DIContainer 초기화 함수
    /// 외부에서 navigationRouter와 useCaseService를 주입받아 사용할 수 있도록 구성
    /// 기본값으로는 각각 새로운 인스턴스를 생성하여 초기화
    init(
        navigationRouter: NavigationRouter = .init(),
        useCaseService: UseCaseService = .init()
    ) {
        self.navigationRouter = navigationRouter
        self.useCaseService = useCaseService
    }
}
