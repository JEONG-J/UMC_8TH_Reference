//
//  KakaoLoginError.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation

/// 카카오 로그인 에러처리
enum KakaoLoginError: LocalizedError {
    case failedToLoginWithKakaoApp
    case failedToLoginWithKakaoWeb
    case failedToFetchUserInfo
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .failedToLoginWithKakaoApp:
            return "카카오톡 앱으로 로그인에 실패했습니다."
        case .failedToLoginWithKakaoWeb:
            return "카카오 계정으로 로그인에 실패했습니다."
        case .failedToFetchUserInfo:
            return "사용자 정보르 가져오자 못했습니다."
        case .unknown(let error):
            return "알 수없는 오류: \(error.localizedDescription)"
        }
    }
}
