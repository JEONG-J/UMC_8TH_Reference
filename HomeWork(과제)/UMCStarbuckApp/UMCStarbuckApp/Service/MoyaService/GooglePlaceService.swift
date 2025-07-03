//
//  GooglePlaceService.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/2/25.
//

import Foundation
import Moya

/// Google Place API와 통신하기 위한 프로토콜 정의
protocol GooglePlaceServiceProtocol {
    /// 키워드 검색을 통해 장소의 대표 사진 photoReference 값을 반환
    func getPhotoReference(query: String) async throws -> String
}

/// GooglePlaceService 구현체 - Google Places API 요청 처리
final class GooglePlaceService: GooglePlaceServiceProtocol {
    /// Moya를 이용한 API 요청 provider
    private let provider: MoyaProvider<GoogleRouter>

    /// 기본 provider에는 verbose 로그를 남기기 위한 NetworkLoggerPlugin 포함
    init(provider: MoyaProvider<GoogleRouter> = MoyaProvider<GoogleRouter>(
        plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
    )) {
        self.provider = provider
    }

    /// 키워드 기반 장소 검색 후 첫 장소의 첫 번째 photoReference를 반환
    ///
    /// - Parameter query: 검색 키워드
    /// - Returns: photoReference 문자열
    /// - Throws: photoReference가 없거나, 요청/디코딩 에러 발생 시 에러 throw
    func getPhotoReference(query: String) async throws -> String {
        do {
            // GoogleRouter enum을 통해 해당 endpoint에 요청
            let response = try await provider.request(.getGooglePlace(query: query))
            
            // JSON 응답을 PlaceResponse 타입으로 디코딩
            let result = try response.map(PlaceResponse.self)
            
            // 결과에서 첫 장소의 첫 photoReference 반환
            if let photoRef = result.results.first?.photos?.first?.photoReference {
                return photoRef
            } else {
                // 사진이 없을 경우 custom 에러 발생
                throw GooglePlaceError.noPhotoReference
            }
        } catch let moyaError as MoyaError {
            // 네트워크 요청 관련 에러 처리
            throw GooglePlaceError.requestFailed(moyaError)
        } catch let decodingError {
            // 디코딩 실패 시 처리
            throw GooglePlaceError.decodingFailed(decodingError)
        }
    }
}
