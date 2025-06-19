//
//  NavigationRouter.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import Foundation

/// 화면 이동을 제어하기 위한 라우팅 프로토콜
protocol NavigationRoutable {
    
    /// 현재 네비게이션 스택에 쌓여 있는 목적지들
    var destination: [NavigationDestination] { get set }
    
    /// 새로운 화면을 네비게이션 스택에 푸시
    func push(to view: NavigationDestination)
    
    /// 현재 화면을 팝 (뒤로 가기)
    func pop()
    
    /// 루트 화면까지 모두 팝 (처음 화면으로 이동)
    func popToRootView()
}

/// SwiftUI에서 상태를 추적할 수 있도록 Observable로 선언된 라우터 클래스
@Observable
class NavigationRouter: NavigationRoutable {
    
    /// 현재까지 쌓인 화면 목적지 목록 (화면 전환 상태)
    var destination: [NavigationDestination] = []
    
    /// 화면을 새로 추가 (푸시)
    /// - Parameter view: 이동할 화면을 나타내는 NavigationDestination
    func push(to view: NavigationDestination) {
        destination.append(view)
    }
    
    /// 마지막 화면을 제거 (뒤로 가기)
    func pop() {
        _ = destination.popLast()
    }
    
    /// 스택을 초기화하여 루트 화면으로 이동
    func popToRootView() {
        destination.removeAll()
    }
}
