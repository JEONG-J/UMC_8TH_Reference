//
//  KakaoKeywordService.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/2/25.
//

import Foundation
import Moya

/// Kakao 로컬 검색 API와 통신하기 위한 프로토콜 정의
protocol KakaoServiceProtocol {
    /// 키워드를 기반으로 장소 정보를 검색하는 함수
    /// - Parameter query: 검색 키워드
    /// - Returns: 검색 결과 KakaoPlaceDocument 배열
    func getKeywordPlace(query: String) async throws -> [KakaoPlaceDocument]
}

/// KakaoService 구현체 - Kakao 로컬 검색 API와의 통신 담당
final class KakaoService: KakaoServiceProtocol {
    
    /// Moya를 이용한 API 요청 provider
    private let provider: MoyaProvider<KakaoRouter>
    
    /// 생성자 - 기본 provider는 verbose 로그 플러그인을 포함함
    init(provider: MoyaProvider<KakaoRouter> = MoyaProvider<KakaoRouter>(
        plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
    )) {
        self.provider = provider
    }
    
    /// 키워드로 Kakao 장소 검색 API를 호출하여 결과 반환
    ///
    /// - Parameter query: 검색 키워드
    /// - Returns: KakaoPlaceDocument 배열
    /// - Throws: 요청 실패 또는 디코딩 실패 시 custom 에러 throw
    func getKeywordPlace(query: String) async throws -> [KakaoPlaceDocument] {
        do {
            // KakaoRouter enum을 통해 요청 생성 및 전송
            let response = try await provider.request(.placeKeyword(query: query))
            
            // 응답을 KakaoPlaceResponse 타입으로 디코딩
            let result = try response.map(KakaoPlaceResponse.self)
            
            // 결과 내 documents 배열 반환
            return result.documents
        } catch let moyaError as MoyaError {
            // Moya 네트워크 요청 실패 처리
            throw KakaoKeywordError.requestFailed(moyaError)
        } catch let decodingError {
            // JSON 디코딩 실패 처리
            throw KakaoKeywordError.decodingFailed(decodingError)
        }
    }
}
