//
//  ContentsViewModel.swift
//  MoyaTest
//
//  Created by Apple Coding machine on 5/9/25.
//

import Foundation
import Moya

@Observable
class ContentsViewModel {
    var userData: UserData?
    let provider: MoyaProvider<UserRotuer>
    let loginProvider: MoyaProvider<AuthRouter>
    
    init(provider: MoyaProvider<UserRotuer> = APIManager.shared.createProvider(for: UserRotuer.self),
             loginProvider: MoyaProvider<AuthRouter> = APIManager.shared.createProvider(for: AuthRouter.self)) {
            self.provider = provider
            self.loginProvider = loginProvider
        }
    
    
       func loginAndStoreTokens() {
           loginProvider.request(.login) { result in
               switch result {
               case .success(let response):
                   do {
                       let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: response.data)
                       let keychainInfo = KeychainManager.standard.saveSession(.init(accessToken: tokenResponse.accessToken, refreshToken: tokenResponse.refreshToken), for: "appNameUser")
                       print("AccessToken, RefreshToken 저장 완료", keychainInfo)
                   } catch {
                       print("토큰 디코딩 실패:", error)
                   }
               case .failure(let error):
                   print("로그인 API 실패:", error)
               }
           }
       }
    
    
    func getUser() async {
        do {
            let response = try await provider.requestAsync(.getPerson(name: "제옹"))
            let user = try JSONDecoder().decode(UserData.self, from: response.data)
            print("유저", user)
        } catch {
            print("요청 또는 디코딩 실패:", error.localizedDescription)
        }
    }
    
    
    func createUser(_ userData: UserData) {
        provider.request(.postPerson(userData: userData)) { result in
            switch result {
            case .success(let response):
                print("POST 성공: \(response.statusCode)")
            case .failure(let error):
                // Error 처리 넣기
                print("error", error)
            }
        }
    }
    
    func updateUserPatch(_ patchData: UserPatchRequest) {
        provider.request(.patchPerson(patchData: patchData)) { result in
            switch result {
            case .success(let response):
                print("PATCH 성공: \(response.statusCode)")
            case .failure(let error):
                // Error 처리 넣기
                print("error", error)
            }
        }
    }
    
    func updateUserPut(_ userData: UserData) {
        provider.request(.putPerson(userData: userData)) { result in
            switch result {
            case .success(let response):
                print("PUT 성공: \(response.statusCode)")
            case .failure(let error):
                // Error 처리
                print("error", error)
            }
        }
    }
    
    func deleteUser(name: String) {
        provider.request(.deletePerson(name: name)) { result in
            switch result {
            case .success(let response):
                print("DELETE 성공: \(response.statusCode)")
            case .failure(let error):
                // Error 처리
                print("error", error)
            }
        }
    }
}


extension MoyaProvider {
    func requestAsync(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
