//
//  OSRMError.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/2/25.
//

import Foundation
import Moya

/// OSRM 경로 탐색 에러
enum OSRMError: Error, LocalizedError {
    case invalidResponse
    case decodingFailed
    case moyaError(MoyaError)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "유효하지 않은 응답입니다."
        case .decodingFailed:
            return "데이터 디코딩에 실패했습니다."
        case .moyaError(let error):
            return "네트워크 오류가 발생했습니다: \(error.localizedDescription)"
        }
    }
}
