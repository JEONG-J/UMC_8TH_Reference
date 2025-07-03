//
//  OSRMService.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/2/25.
//

import Foundation
import Moya

/// OSRM 경로 탐색 API와 통신하는 서비스 프로토콜
protocol OSRMServiceProtocol {
    /// 출발지와 도착지를 포함한 경로 요청 객체를 기반으로 경로 정보를 받아오는 메서드
    /// - Parameter route: 출발/도착지 좌표를 포함한 요청 모델
    /// - Returns: OSRM 서버로부터 받은 경로 응답 모델
    func getRouteRoad(route: OSRMRouteRequset) async throws -> OSRMRouteResponse
}

/// 실제 OSRM API 호출을 담당하는 서비스 클래스
final class OSRMService: OSRMServiceProtocol {
    
    /// Moya를 사용한 OSRM API 요청 프로바이더
    private let provider: MoyaProvider<OSRMRouter>
    
    /// 기본 initializer - verbose 로그 플러그인을 포함한 provider 생성
    init(provider: MoyaProvider<OSRMRouter> = MoyaProvider<OSRMRouter>(
        plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
    )) {
        self.provider = provider
    }
    
    /// 출발/도착지를 포함한 경로 요청을 보내고 경로 결과를 반환
    ///
    /// - Parameter route: 출발지와 도착지를 포함한 경로 요청 모델
    /// - Returns: OSRM API 응답 모델 (경로 정보 포함)
    /// - Throws: 요청 실패 시 `OSRMError`로 에러를 던짐
    func getRouteRoad(route: OSRMRouteRequset) async throws -> OSRMRouteResponse {
        do {
            // 실제 네트워크 요청 전송
            let response = try await provider.request(.getRoute(route: route))
            
            // 응답을 OSRMRouteResponse 타입으로 디코딩
            let result = try response.map(OSRMRouteResponse.self)
            return result
        } catch let moyaError as MoyaError {
            // 네트워크 요청 실패 시 custom 에러 처리
            throw OSRMError.moyaError(moyaError)
        } catch {
            // 디코딩 실패 시 custom 에러 처리
            throw OSRMError.decodingFailed
        }
    }
}
