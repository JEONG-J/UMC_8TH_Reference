//
//  SignUpViewModels.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation

@Observable
class SignUpViewModel {
    // MARK: - Property
    var nickname: String = ""
    var email: String = ""
    var password: String = ""
    var keychainManager: KeychainManager = .standard
    
    // MARK: - KeychainSave
    /// 키체인 저장 함수
    public func saveKeychain() async {
        let savedKeychain = keychainManager.saveSession(convertUserKeychain(), for: "UMCStarbuckApp")
        print("키체인 저장 정보:", savedKeychain)
    }
    
    /// 키체인 모델 반환
    /// - Returns: 키체인 저장 모델로 반환
    private func convertUserKeychain() -> UserKeychain {
        return .init(userName: nickname, userId: email, userPassword: password)
    }
}
