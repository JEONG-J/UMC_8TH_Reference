//
//  KakakoLoginManager.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

class KakakoLoginManager {
    public func login() async throws -> KakaoUser {
        let token: OAuthToken
        
        if UserApi.isKakaoTalkLoginAvailable() {
            do {
                token = try await loginWithKakaoApp()
            } catch {
                throw KakaoLoginError.failedToLoginWithKakaoApp
            }
        } else {
            do {
                token = try await loginWithKakaoWeb()
            } catch {
                throw KakaoLoginError.failedToLoginWithKakaoWeb
            }
        }
        
        return try await getUserInfo(token: token)
    }
    
    private func loginWithKakaoApp() async throws -> OAuthToken {
        try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk { token, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let token = token {
                    continuation.resume(returning: token)
                } else {
                    continuation.resume(throwing: KakaoLoginError.failedToLoginWithKakaoApp)
                }
            }
        }
    }
    
    private func loginWithKakaoWeb() async throws -> OAuthToken {
        try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount { token, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let token = token {
                    continuation.resume(returning: token)
                } else {
                    continuation.resume(throwing: KakaoLoginError.failedToLoginWithKakaoWeb)
                }
            }
        }
    }
    
    private func getUserInfo(token: OAuthToken) async throws -> KakaoUser {
        try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.me { user, error in
                if let error = error {
                    continuation.resume(throwing: KakaoLoginError.unknown(error))
                } else if let user = user {
                    let kakaoUser = KakaoUser(
                        nickname: user.kakaoAccount?.profile?.nickname ?? "닉네임 정보 없음",
                        accessToken: token.accessToken
                    )
                    continuation.resume(returning: kakaoUser)
                } else {
                    continuation.resume(throwing: KakaoLoginError.failedToFetchUserInfo)
                }
            }
        }
    }
}
