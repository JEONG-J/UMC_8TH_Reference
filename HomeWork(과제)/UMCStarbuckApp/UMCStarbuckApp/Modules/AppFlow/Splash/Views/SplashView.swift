//
//  SplashView.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import SwiftUI

/// 앱 실행 시 보여지는 스플래시 화면
/// 일정 시간 대기 후, 키체인에 저장된 로그인 정보 유무에 따라 화면 전환
struct SplashView: View {
    
    // MARK: - Property

    /// 앱의 흐름(상태 전환)을 제어하는 뷰모델 (환경 객체로 주입받음)
    @EnvironmentObject var appFlowViewModel: AppFlowViewModel
    
    /// 키체인 매니저 (싱글톤 인스턴스 사용)
    private let keychainManager: KeychainManager = .standard
    
    // MARK: - Constants

    /// 스플래시 뷰에서 사용하는 상수들을 정의한 내부 enum
    fileprivate enum SplashConstants {
        static let timeNanoSeconds: UInt64 = 2_500_000_000   // 2.5초 (나노초 단위)
        static let keyChainValue: String = "UMCStarbuckApp"  // 키체인에서 사용할 키 이름
    }
    
    // MARK: - Body

    var body: some View {
        ZStack {
            // 배경 색상 전체 적용
            Color.green01.ignoresSafeArea()
            
            // 앱 로고 이미지
            Image(.logo)
        }
        .task {
            // 스플래시를 2.5초간 보여준 후, 키체인 상태 확인
            try? await Task.sleep(nanoseconds: SplashConstants.timeNanoSeconds)
            await checkKeychain()
        }
    }
    
    /// 키체인에 저장된 로그인 정보가 있는지 확인하고
    /// 로그인 상태면 홈(tab), 아니면 로그인 화면으로 이동
    private func checkKeychain() async {
        if keychainManager.loadSession(for: SplashConstants.keyChainValue) != nil {
            // 자동 로그인 → 탭 화면으로 이동
            await appFlowViewModel.changeAppState(.tab)
        } else {
            // 로그인 정보 없음 → 로그인 화면으로 이동
            await appFlowViewModel.changeAppState(.login)
        }
    }
}

#Preview {
    SplashView()
}
