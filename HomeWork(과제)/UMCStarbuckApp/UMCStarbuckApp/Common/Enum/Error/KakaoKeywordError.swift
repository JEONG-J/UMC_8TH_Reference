//
//  KakaoKeywordError.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/2/25.
//

import Foundation
import Moya

/// Kakao 키워드 검색 API 요청에서 발생할 수 있는 오류들을 정의한 열거형입니다.
enum KakaoKeywordError: Error, LocalizedError {
    
    /// 네트워크 요청 실패 (Moya에서 발생한 에러 포함)
    case requestFailed(MoyaError)
    
    /// 응답 디코딩 실패 (Decodable 파싱 중 오류 발생)
    case decodingFailed(Error)

    /// 사용자에게 보여줄 수 있는 에러 메시지를 제공합니다.
    var errorDescription: String? {
        switch self {
        case .requestFailed(let err):
            // 네트워크 요청 실패 메시지 반환
            return "요청 실패: \(err.localizedDescription)"
            
        case .decodingFailed(let err):
            // JSON 디코딩 실패 메시지 반환
            return "디코딩 실패: \(err.localizedDescription)"
        }
    }
}
