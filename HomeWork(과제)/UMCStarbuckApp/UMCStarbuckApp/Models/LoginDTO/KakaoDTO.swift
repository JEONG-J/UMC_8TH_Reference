//
//  KakaoDTO.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation

/// Kakao 로그인 후 공통으로 사용될 사용자 데이터 전달용 프로토콜
/// accessToken과 nickname은 인증 이후 필요한 최소 정보로 정의됨
protocol KakaoDTO {
    
    /// 카카오에서 발급된 사용자 인증 토큰 (Bearer Token 등 서버 인증 시 사용)
    var accessToken: String { get }
    
    /// 사용자 닉네임 (카카오 프로필에서 가져옴)
    var nickname: String { get }
}

/// Kakao 로그인 후 획득한 사용자 정보를 담는 구조체
/// KakaoDTO 프로토콜을 채택하여 공통 인터페이스를 제공
struct KakaoUser: KakaoDTO {
    
    /// 사용자 닉네임
    var nickname: String
    
    /// 카카오 인증 토큰
    var accessToken: String
}
