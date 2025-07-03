//
//  StableDiffusionError.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/3/25.
//

import Foundation
import Moya

/// 이미지 생성 에러 처리
enum StableDiffusionError: Error, LocalizedError {
    case moyaError(MoyaError)
    case decodingError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .moyaError(let error):
            return "네트워크 오류: \(error.localizedDescription)"
        case .decodingError:
            return "디코딩 오류 발생"
        case .unknown:
            return "알 수 없는 오류 발생"
        }
    }
}
