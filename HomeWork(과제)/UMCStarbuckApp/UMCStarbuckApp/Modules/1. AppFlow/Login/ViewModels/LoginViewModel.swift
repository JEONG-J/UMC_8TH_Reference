//
//  LoginViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/17/25.
//

import Foundation

@Observable
class LoginViewModel {
    // MARK: - Property
    let keychainValue: String = "UMCStarbuckApp"
    
    var id: String = ""
    var password: String = ""
    var container: DIContainer
    private var appFlowViewModel: AppFlowViewModel
    
    // MARK: - ManagerProperty
    var keychainManager: KeychainManager = .standard
    
    // MARK: - Init
    init(container: DIContainer, appFlowViewModel: AppFlowViewModel) {
        self.container = container
        self.appFlowViewModel = appFlowViewModel
    }
    
    // MARK: - Login
    
    /// 앱 자체 로그인 함수
    public func actionLoginButtonTap() async {
        guard let savedSession = keychainManager.loadSession(for: keychainValue) else {
            print("키체인에 저장된 세션 없음")
            return
        }
        
        if savedSession.userId == id && savedSession.userPassword == password {
            print("로그인 성공")
            await self.changeView()
        } else {
            print("로그인 실패")
        }
    }
    
    /// 카카오 로그인 함수
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
    
    // MARK: - PrivateMethod
    
    /// 로그인 성공 시 작동시키는 함수
    private func changeView() async {
        await appFlowViewModel.changeAppState(.tab)
    }
    
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
