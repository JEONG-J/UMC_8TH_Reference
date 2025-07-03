//
//  StoreImageError.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/2/25.
//

import Foundation
import Moya

/// Google Place API 요청에서 발생할 수 있는 오류들을 정의한 열거형입니다.
enum GooglePlaceError: Error, LocalizedError {
    
    /// 네트워크 요청 실패 (MoyaError 포함)
    case requestFailed(MoyaError)
    
    /// 응답 디코딩 실패 (Decoding 관련 에러 포함)
    case decodingFailed(Error)
    
    /// 사진 요청 시 photoReference 값이 없는 경우
    case noPhotoReference
    
    /// 사용자에게 보여줄 수 있는 오류 메시지를 제공합니다.
    var errorDescription: String? {
        switch self {
        case .requestFailed(let err):
            return "요청 실패: \(err.localizedDescription)"  // 네트워크 요청 실패 사유 포함
            
        case .decodingFailed(let err):
            return "디코딩 실패: \(err.localizedDescription)" // JSON 파싱 실패 사유 포함
            
        case .noPhotoReference:
            return "사진 참조를 찾을 수 없습니다." // photoReference가 nil인 경우
        }
    }
}
