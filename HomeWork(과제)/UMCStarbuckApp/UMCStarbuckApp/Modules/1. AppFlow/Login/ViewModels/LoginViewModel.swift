//
//  LoginViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import Foundation

/// 로그인 화면에서 사용되는 ViewModel
/// 사용자 ID/비밀번호 로그인 및 카카오 로그인 기능을 제공하며, 키체인과 앱 흐름 전환을 관리함
@Observable
class LoginViewModel {
    
    // MARK: - Property
    
    /// 키체인에 저장할 때 사용할 고유 식별자 값
    let keychainValue: String = "UMCStarbuckApp"
    
    /// 사용자 입력 ID
    var id: String = ""
    
    /// 사용자 입력 비밀번호
    var password: String = ""
    
    /// 의존성 주입 컨테이너
    var container: DIContainer
    
    /// 앱 흐름 상태를 관리하는 AppFlowViewModel
    private var appFlowViewModel: AppFlowViewModel
    
    // MARK: - ManagerProperty
    
    /// 키체인 접근을 위한 매니저 객체
    var keychainManager: KeychainManager = .standard
    
    // MARK: - Init
    
    /// ViewModel 초기화
    /// - Parameters:
    ///   - container: DIContainer를 주입받아 서비스 사용
    ///   - appFlowViewModel: 앱의 상태 전환을 위한 뷰모델
    init(container: DIContainer, appFlowViewModel: AppFlowViewModel) {
        self.container = container
        self.appFlowViewModel = appFlowViewModel
    }
    
    // MARK: - Login
    
    /// 앱 자체 로그인 처리 함수
    /// 키체인에 저장된 ID/비밀번호와 입력값을 비교하여 로그인 성공 여부 판단
    public func actionLoginButtonTap() async {
        guard let savedSession = keychainManager.loadSession(for: keychainValue) else {
            print("키체인에 저장된 세션 없음")
            return
        }
        
        if savedSession.userId == id && savedSession.userPassword == password {
            await self.changeView()
            print("로그인 성공")
        } else {
            print("로그인 실패")
        }
    }
    
    /// 카카오 로그인 처리 함수
    /// 카카오 SDK를 통해 로그인 후 토큰 및 사용자 정보를 키체인에 저장하고 앱 상태 전환
    public func kakaoLogin() async {
        do {
            let user = try await container.useCaseService.kakaoManager.login()
            await self.loadAndSaveKeychain(user)
            await self.changeView()
        } catch {
            if let kakaoError = error as? KakaoLoginError {
                print("카카오 에러메시지:", kakaoError.localizedDescription)
            } else {
                print("에러 메시지:", error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private Method
    
    /// 로그인 성공 시 앱의 메인 탭 화면으로 상태 전환
    private func changeView() async {
        await appFlowViewModel.changeAppState(.tab)
    }
    
    /// 카카오 로그인 후 받은 사용자 정보를 키체인에 저장
    /// 기존에 저장된 세션을 불러와 카카오 토큰과 사용자 이름만 업데이트
    private func loadAndSaveKeychain(_ kakaoUser: KakaoUser) async {
        guard var user = keychainManager.loadSession(for: keychainValue) else {
            print("키체인에 저장된 세션 없음")
            return
        }
        
        user.kakaoAccessToken = kakaoUser.accessToken
        user.userName = kakaoUser.nickname
        
        let savedKeychain = keychainManager.saveSession(user, for: keychainValue)
        print("액세스 토큰 키체인 저장", savedKeychain)
    }
}
